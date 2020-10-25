FROM ubuntu
ENV TZ=America/New_York
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  build-essential \
  git \ 
  libusb-1.0-0-dev \
  pkg-config \
  wget

RUN \
  git clone https://gitlab.com/DavidGriffith/minipro.git && \
  cd minipro && \
  make && \
  make install

RUN \
  cd / && \
  wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz && \
  tar xvzf vasm.tar.gz && \
  cd vasm && \
  make CPU=6502 SYNTAX=oldstyle && \
  cp vasm6502_oldstyle /usr/bin && \
  cp vobjdump /usr/bin