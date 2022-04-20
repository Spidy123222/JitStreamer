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

WORKDIR /Product
RUN git clone https://github.com/jkcoxson/rusty_libimobiledevice.git
WORKDIR /Product/rusty_libimobiledevice
RUN mkdir submodules


# clone modules
# RUN cd /usr/local/lib
WORKDIR /Product
RUN git clone https://github.com/libimobiledevice/libplist.git
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git
RUN git clone https://github.com/jkcoxson/plist_plus.git
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git
#RUN cd /usr/local/lib && git clone https://github.com/openssl/openssl.git


# Build Static's

#RUN cd /usr/local/lib/openssl && ./Configure --static -static && make && make install
WORKDIR /Product/libplist
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
WORKDIR /Product/libimobiledevice-glue
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
WORKDIR /Product/libusbmuxd
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
WORKDIR /Product/libimobiledevice
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install

#WORKDIR /Product/rusty_libimobiledevice
#RUN cargo build --release
#WORKDIR /Product/plist_plus
#RUN cargo build --release
WORKDIR /Product
RUN git clone https://github.com/jkcoxson/JitStreamer.git
WORKDIR /Product/JitStreamer
RUN cargo build --release

WORKDIR /Product/JitStreamer/target/release/
ENTRYPOINT ls && ./jit_streamer