FROM theasp/novnc:latest

RUN apt-get update -qq && apt-get update && apt-get install -y build-essential libwxgtk3.0-gtk3-dev

RUN cd / && \
    apt-get install -y libgtk2.0-dev libgtk-3-dev && \
    wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.2.4/wxWidgets-3.2.4.tar.bz2 && \
    tar -xvjf wxWidgets-3.2.4.tar.bz2 && \
    cd wxWidgets-3.2.4 && \
    mkdir compiling && \
    cd compiling && \
    ../configure --disable-shared && \
    make -j3 && \
    make install

WORKDIR /wxtetris

COPY . .

RUN make
