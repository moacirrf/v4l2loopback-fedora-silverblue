modprobe videodev
insmod ./build/v4l2loopback/v4l2loopback.ko devices=1 exclusive_caps=1
