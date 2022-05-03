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
    build-essential \
    #cython \
    libgnutls28-dev \ 
    git \
    autoconf \
    automake \
    python3-pip \
    doxygen \
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

RUN pip install Cython --install-option="--no-cython-compile"

# Update new packages
RUN apt-get update

# install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# create structure
RUN echo 'Fire Through the flames'
WORKDIR /Product
RUN git clone https://github.com/jkcoxson/rusty_libimobiledevice.git
WORKDIR /Product/rusty_libimobiledevice
RUN mkdir submodules


# clone modules
# RUN cd /usr/local/lib
WORKDIR /Product
#RUN git clone https://github.com/libimobiledevice/libplist.git
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git
RUN git clone https://github.com/jkcoxson/plist_plus.git
#RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git
#RUN cd /usr/local/lib && git clone https://github.com/openssl/openssl.git


# Build Static's

#RUN cd /usr/local/lib/openssl && ./Configure --static -static && make && make install
#WORKDIR /Product/libplist
#RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
WORKDIR /Product/libimobiledevice-glue
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
WORKDIR /Product/libusbmuxd
RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install
#WORKDIR /Product/libimobiledevice
#RUN ./autogen.sh --enable-static --disable-shared --without-cython && make && make install

#WORKDIR /Product/rusty_libimobiledevice
#RUN cargo build --release
#WORKDIR /Product/plist_plus
#RUN cargo build --release

#RUN apt-get install -y cmake \
#    python-jinja2

RUN apt install xorg-dev libxcb-shape0-dev libxcb-xfixes0-dev clang avahi-daemon libavahi-client-dev -y
WORKDIR /Product
RUN git clone https://github.com/jkcoxson/mdns.git
RUN git clone https://github.com/windy1/zeroconf-rs.git
RUN git clone https://github.com/jkcoxson/netmuxd.git
WORKDIR /Product/netmuxd
RUN cargo build --release
WORKDIR /Product
RUN git clone https://github.com/jkcoxson/JitStreamer.git
WORKDIR /Product/JitStreamer
RUN cargo build --release

RUN apt install npm -y && npm install -g @vue/cli

WORKDIR /var/lib/lockdown
WORKDIR /DMG
WORKDIR /Product/JitStreamer/target/release/dist
WORKDIR /Product/JitStreamer/target/release/

RUN echo 'hi to them all'
#RUN curl https://raw.githubusercontent.com/Spidy123222/JitStreamer/Docker/Docker/start.sh -o /Product/JitStreamer/target/release/start.sh
#RUN chmod +x /Product/JitStreamer/target/release/start.sh

ENTRYPOINT export RUST_LOG=trace; /Product/JitStreamer/target/release/jit_streamer export & RUST_LOG=trace; /Product/netmuxd/target/release/netmuxd

#ENTRYPOINT export RUST_LOG=trace && ls && ./jit_streamer && cd /Product/netmuxd/target/release/ && ./netmuxd && cd /Product/JitStreamer/target/release/