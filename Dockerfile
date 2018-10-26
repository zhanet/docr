FROM ubuntu:18.04
MAINTAINER zhanet "zhanet@163.com"

RUN apt-get update -q && apt-get install -yq \
git wget python3 python3-pip postgresql-client \
openssh-server tesseract-ocr tesseract-ocr-chi-sim \
&& mkdir /var/run/sshd && mkdir /root/.ssh \
&& echo "root:ubuntu" | chpasswd \
&& sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& apt-get clean && apt-get autoclean

ENV WORKDIR /home/docr

WORKDIR $WORKDIR
COPY ./bin/c* ./
RUN chmod +x ./c* \
&& ./cinit

EXPOSE 22
CMD ["./cstart"]
