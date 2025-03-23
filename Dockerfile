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
RUN apk add gcc musl-dev
ADD hello.c .
# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
RUN gcc -Oz -static -o hello hello.c
RUN strip hello

FROM scratch
COPY --from=builder hello /bin/hello
CMD ["/bin/hello"]
