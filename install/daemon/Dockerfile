FROM ubuntu:18.04
RUN apt update
RUN apt install -y libcurl3 libavahi-client3

COPY Butler /Butler
RUN /Butler/install.sh
RUN rm -rf /Butler

RUN apt install -y iproute2
RUN apt install -y strace
RUN apt install -y vim

EXPOSE 9090
WORKDIR /opt/ravenna-alsa
# CMD ["/opt/ravenna-alsa/Merging_RAVENNA_Daemon"]
