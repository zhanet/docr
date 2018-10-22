FROM ubuntu:18.04
MAINTAINER zhanet "zhanet@163.com"

RUN apt-get update -qq
&& apt-get install -y python3 tesseract-ocr openssh-server \
&& mkdir /var/run/sshd && mkdir /root/.ssh \
&& echo "root:ubuntu" | chpasswd \
&& sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& apt-get clean && apt-get autoclean

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
