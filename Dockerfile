FROM arillso/ansible:2.11.6

LABEL "maintainer"="Simon Baerlocher <s.baerlocher@sbaerlocher.ch>" \
	"org.opencontainers.image.authors"="Simon Baerlocher <s.baerlocher@sbaerlocher.ch>" \
	"org.opencontainers.image.vendor"="arillso" \
	"org.opencontainers.image.licenses"="MIT" \
	"org.opencontainers.image.url"="https://github.com/arillso/vagrant.container" \
	"org.opencontainers.image.documentation"="https://github.com/arillso/vagrant.container" \
	"org.opencontainers.image.source"="https://github.com/arillso/vagrant.container" 

USER root

ENV \
	USER=vagrant \
	GROUP=vagrant \
	UID=1001 \
	GID=1001

RUN set -eux \
	&& addgroup -g ${GID} ${GROUP} \
	&& adduser -h /home/vagrant -s /bin/bash -G ${GROUP} -D -u ${UID} ${USER} \
	\
	&& mkdir /home/vagrant/.gnupg \
	&& chown vagrant:vagrant /home/vagrant/.gnupg \
	&& chmod 0700 /home/vagrant/.gnupg \
	\
	&& mkdir /home/vagrant/.ssh \
	&& chown vagrant:vagrant /home/vagrant/.ssh \
	&& chmod 0700 /home/vagrant/.ssh \
	\
	&& apk --update --no-cache add \
	openssh \
	sudo

RUN ssh-keygen -A \
	&& echo 'vagrant:vagrant' | chpasswd > /dev/null 2>&1 \
	&& echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant \
	&& mkdir -p /home/vagrant/.ssh \
	&& wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys > /dev/null 2>&1 \
	&& wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant -O /home/vagrant/.ssh/id_rsa > /dev/null 2>&1 \
	&& chown -R vagrant:vagrant /home/vagrant/.ssh \
	&& chmod 0400 /home/vagrant/.ssh/id_rsa \
	&& chmod 0600 /home/vagrant/.ssh/authorized_keys \
	&& chmod 0700 /home/vagrant/.ssh

EXPOSE 22

USER vagrant

CMD ["sudo","/usr/sbin/sshd", "-D"]
