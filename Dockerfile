ARG FEDORA_VERSION=43
FROM registry.fedoraproject.org/fedora:$FEDORA_VERSION as v4l2loopback_git
WORKDIR workdir
RUN dnf install git -y
RUN git clone https://github.com/umlaeute/v4l2loopback
RUN cd v4l2loopback
FROM registry.fedoraproject.org/fedora:$FEDORA_VERSION
WORKDIR workdir
VOLUME ["/build"]
RUN dnf update -y
RUN dnf install kernel-modules-internal-`uname -r` kernel-devel-`uname -r` awk  -y
COPY --from=v4l2loopback_git workdir/v4l2loopback ./
RUN make clean
RUN make
RUN rm -rf ./build/v4l2loopback
RUN mkdir -p ./build/v4l2loopback
RUN cp ./v4l2loopback.ko ./build/v4l2loopback
