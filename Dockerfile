FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Stockholm

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y build-essential libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev libreadline6-dev libncurses5-dev libfftw3-dev libxt-dev libudev-dev pkg-config git cmake qt5-default qt5-qmake qttools5-dev qttools5-dev-tools qtdeclarative5-dev qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev qtwebengine5-dev libqt5svg5-dev libqt5websockets5-dev libjack-jackd2-dev jackd2 

COPY /supercollider /supercollider
COPY /sc3-plugins /sc3-plugins

WORKDIR /supercollider/build

RUN cmake -DSC_QT=OFF -DSC_EL=OFF ..
RUN make
RUN make install
RUN ldconfig

WORKDIR /sc3-plugins/build

RUN cmake -DSC_PATH=/supercollider ..
RUN make
RUN make install
RUN ldconfig

RUN alias sclang=/supercollider/build/lang/sclang

WORKDIR /opt/

COPY darkice /usr/bin/darkice
COPY darkice.cfg /etc/darkice.cfg
COPY init.sh .

RUN apt-get install -y libmp3lame-dev libogg-dev libvorbis-dev libasound-dev

