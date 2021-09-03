FROM centos:7

RUN yum clean all && yum install https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/python3-pip-9.0.3-7.el7_8.noarch.rpm -y && \
    yum install epel-release -y && yum update -y && \
    yum install zip unzip mysql jq python3-setuptools git gcc gcc-c++ fontconfig python-pip python-devel python-subprocess32 which sysstat net-tools -y && \
    yum install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 -y && \
    yum install ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc -y && \
    yum clean all

RUN pip install --upgrade pip==20.3 && pip install requests

RUN echo 'export JAVA_HOME=/home/incorta/jdk1.8.0_131' >> /etc/profile && echo 'export PATH=$PATH:/home/incorta/jdk1.8.0_131/bin' >> /etc/profile && useradd -G wheel incorta

RUN mkdir /incorta-source /scripts

COPY start-up.sh id_rsa known_hosts /

RUN chmod +x /start-up.sh && chown -R incorta:incorta /scripts /incorta-source

USER incorta
WORKDIR /home/incorta

ENV JAVA_HOME=/home/incorta/jdk1.8.0_131
ENV PATH=$PATH:/home/incorta/jdk1.8.0_131/bin
RUN pip install --user requests && pip install --user setuptools -U

RUN echo -e "[gsfuse] \nname=gcsfuse (packages.cloud.google.com)\
\nbaseurl=https://packages.cloud.google.com/yum/repos/gcsfuse-el7-x86_64\
\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=0\
\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg\n\
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/gcsfuse.repo

RUN yum install gcsfuse -y 



ENTRYPOINT ["/start-up.sh"]
