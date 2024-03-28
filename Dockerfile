FROM fedora:40 as v4l2loopback_git
RUN dnf install git -y
RUN git clone https://github.com/umlaeute/v4l2loopback

FROM fedora:40
WORKDIR v4l2loopback
VOLUME ["/build"]
RUN dnf update -y
RUN dnf install kernel-modules-internal-`uname -r` kernel-devel-`uname -r` -y
COPY --from=v4l2loopback_git v4l2loopback ./
RUN make clean
RUN make
RUN rm -rf ./build/v4l2loopback
RUN mkdir ./build/v4l2loopback
RUN cp ./v4l2loopback.ko ./build/v4l2loopback
