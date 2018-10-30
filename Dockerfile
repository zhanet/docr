FROM ubuntu:18.04
MAINTAINER ze <zhanet@163.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 WORKDIR=/home/docr

RUN apt-get update -q && apt-get install tzdata && dpkg-reconfigure -f noninteractive tzdata \
&& apt-get install -yq --no-install-recommends openssh-server python3 python3-pip \
git wget postgresql-client tesseract-ocr tesseract-ocr-chi-sim \
&& mkdir /var/run/sshd && mkdir /root/.ssh \
&& echo "root:ubuntu" | chpasswd \
&& sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& apt-get clean && apt-get autoclean

WORKDIR $WORKDIR
COPY ./bin/cinit /boot/
RUN chmod +x /boot/cinit && /boot/cinit

EXPOSE 22
CMD ["./bin/cstart"]
