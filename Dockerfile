FROM ubuntu:18.04
MAINTAINER zhanet "zhanet@163.com"

RUN apt-get update -qq && apt-get install -yq \
git wget python3 openssh-server tesseract-ocr tesseract-ocr-chi-sim \
&& mkdir /var/run/sshd && mkdir /root/.ssh \
&& echo "root:ubuntu" | chpasswd \
&& sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& apt-get clean && apt-get autoclean

ENV WORKDIR /root
COPY ./scripts/c*.sh $WORKDIR/
RUN chmod +x $WORKDIR/c*.sh
RUN $WORKDIR/clone.sh

EXPOSE 22
CMD ["/root/cstart.sh"]
