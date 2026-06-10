# Copyright 2025 Nils Knieling
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM docker.io/library/alpine:latest as builder
# Architecture component of TARGETPLATFORM. Eg. amd64, arm64
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH
RUN echo "CPU arch: ${TARGETARCH}"
RUN apk add gcc musl-dev binutils
ADD hello.c .
# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
# Size-critical linker flags:
#   --build-id=none      : drop the .note.gnu.build-id section
#   -z max-page-size=4096 : avoid 64K page alignment padding (huge win on aarch64)
#   -z norelro           : drop the RELRO program header / padding
#   --no-eh-frame-hdr    : drop the exception-frame header
# -no-pie avoids the static-PIE dynamic sections (.dynsym/.dynamic/...) that
# musl-gcc emits by default, which shrinks the binary significantly.
RUN gcc -Oz -s -static -no-pie -nostartfiles \
	-Wl,--build-id=none \
	-Wl,-z,max-page-size=0x1000 \
	-Wl,-z,norelro \
	-Wl,--no-eh-frame-hdr \
	-D DOCKER_ARCH="\"${TARGETARCH}\"" -o "hello" "hello.c"
RUN echo "Before strip:" && readelf -S "hello" && echo "Size:" && ls -la "hello"
RUN strip \
	-R .comment \
	-R .eh_frame \
	-R .tbss \
	-R .note.gnu.property \
	-R .note.ABI-tag \
	-s "hello"
RUN echo "After strip:" && readelf -S "hello" && echo "Size:" && ls -la "hello"

FROM scratch
COPY --from=builder 'hello' '/@'
CMD ["/@"]
