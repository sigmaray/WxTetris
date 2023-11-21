FROM theasp/novnc:latest

RUN apt-get update -qq && apt-get update && apt-get install -y build-essential libwxgtk3.0-gtk3-dev

WORKDIR /wxtetris

COPY . .

RUN make

