# Retreive Base Image
FROM ubuntu:latest

# setup enviorment
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# open ports
EXPOSE 9993
EXPOSE 443 
EXPOSE 32498
EXPOSE 62078
EXPOSE 50261
EXPOSE 80
EXPOSE 8069 




# Grab dependancies
RUN apt-get update && apt-get install -y git \ 
    libgnutls28-dev \ 
    build-essential \
    git \
    autoconf \
    automake \
    doxygen \
    cython \
    curl \
    libssl-dev \
    pkg-config \
    libusb-1.0 \
    libtool-bin \
    libplist-dev \
    udev \
    libssl-dev \
    libgcrypt20-dev \
    libcrypto++-dev \
    libcurlpp-dev \
    libcrypto++-dev \
    libssl-dev \
    curl \
    python3-pycurl \
    libwww-curl-perl

# Update new packages
RUN apt-get update

# install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# create structure
RUN echo jojo
RUN cd /usr/local/lib && git clone https://github.com/jkcoxson/rusty_libimobiledevice.git
RUN cd /usr/local/lib/rusty_libimobiledevice && mkdir submodules

# clone modules
# RUN cd /usr/local/lib
RUN cd /usr/local/lib && git clone https://github.com/libimobiledevice/libplist.git
RUN cd /usr/local/lib && git clone https://github.com/libimobiledevice/libusbmuxd.git
RUN cd /usr/local/lib && git clone https://github.com/jkcoxson/plist_plus.git
RUN cd /usr/local/lib && git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN cd /usr/local/lib && git clone https://github.com/libimobiledevice/libimobiledevice-glue.git
RUN cd /usr/local/lib && git clone https://github.com/openssl/openssl.git


# Build Static's
RUN cd /usr/local/lib/openssl && ./Configure --static -static && make && make install
RUN cd /usr/local/lib/libplist && ./autogen.sh --enable-static && make && make install
RUN cd /usr/local/lib/libimobiledevice-glue && ./autogen.sh --enable-static && make && make install
RUN cd /usr/local/lib/libusbmuxd && ./autogen.sh --enable-static && make && make install
RUN cd /usr/local/lib/libimobiledevice && ./autogen.sh --enable-static && make && make install


RUN cd /usr/local/lib/rusty_libimobiledevice && cargo build --release
RUN cd /usr/local/lib/plist_plus && cargo build --release

RUN cd /usr/local/lib && git clone https://github.com/jkcoxson/JitStreamer.git && cd JitStreamer && cargo build --release
