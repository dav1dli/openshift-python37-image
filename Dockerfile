FROM registry.access.redhat.com/ubi8/s2i-base
LABEL com.redhat.component="openshift-python37-ubi" \
      name="openshift-python37-ubi8" \
      version="3.7" \
      architecture="x86_64" \
      io.k8s.display-name="Openshift Python 3.7 Base" \
      io.k8s.description="Openshift Python 3.7 Base" \
      io.openshift.tags="openshift,python,python3,builder"

ENV PYTHON_VERSION=3.7

RUN INSTALL_PKGS="gcc openssl-devel bzip2-devel libffi-devel make wget" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    rm -rf /var/cache/yum && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar xzf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm /usr/src/Python-3.7.4.tgz && \
    ln -s /usr/local/bin/python3.7 /usr/bin/python3 && \
    ln -s /usr/local/bin/pip3.7 /usr/bin/pip3 && \
    pip3 install --upgrade pip && \
    pip3 install pipenv pylint && \
    chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
