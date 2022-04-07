# Retreive Base Image
FROM ubuntu:latest

# install rust
RUN curl https://sh.rustup.rs -sSf | sh -y

# Grab dependancies
RUN apt-get install -y git \ 
    gnutls \ 
    openssl \
    build-essential \
    pkg-config \
    checkinstall \
    git \
    autoconf \
    automake

# create structure
RUN mkdir libi
RUN cd libi
RUN git clone https://github.com/jkcoxson/rusty_libimobiledevice.git
RUN cd rusty_libimobiledevice
RUN mkdir submodules
RUN cd submodules

# clone modules
RUN git clone https://github.com/libimobiledevice/libplist.git
RUN git clone https://github.com/libimobiledevice/usbmuxd.git
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git

RUN cd ..
RUN command cargo build --release