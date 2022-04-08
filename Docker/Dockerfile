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
    openssl \
    build-essential \
    git \
    autoconf \
    automake \
    doxygen \
    cython \
    curl \
    libssl-dev \
    pkg-config

# Update new packages
RUN apt-get update

# install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

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

RUN cd rusty_libimobiledevice && cargo build --release

RUN cd .. && git clone https://github.com/jkcoxson/JitStreamer.git && cd JitStreamer && cargo build --release