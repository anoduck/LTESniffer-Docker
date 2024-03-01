FROM ubuntu:18.04

WORKDIR /root/Sandbox

RUN apt-get update && apt-get upgrade -y

RUN apt-get install autoconf automake build-essential ccache cmake cpufrequtils doxygen ethtool \
g++ git inetutils-tools libboost-all-dev libncurses5 libncurses5-dev libusb-1.0-0 libusb-1.0-0-dev \
libusb-dev python3-dev python3-mako python3-numpy python3-requests python3-scipy python3-setuptools \
python3-ruamel.yaml -y

COPY uhd /root/Sandbox/uhd

WORKDIR /root/Sandbox/uhd/host/build

RUN cmake ../ && make -j$(nproc) && make install && ldconfig

RUN uhd_images_downloader

RUN apt-get install build-essential git cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev \
libconfig++-dev libsctp-dev -y

RUN apt-get install libglib2.0-dev libudev-dev libcurl4-gnutls-dev libboost-all-dev qtdeclarative5-dev \
libqt5charts5-dev -y

COPY LTESniffer /root/Sandbox/LTESniffer

WORKDIR /root/Sandbox/LTESniffer/build

RUN cmake ../ -DDISABLE_SIMD=on && make -j$(nproc)

ENTRYPOINT [ "/root/Sandbox/LTESniffer/build/src/LTESniffer" ]
