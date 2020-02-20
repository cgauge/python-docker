FROM ubuntu:18.04

ENV PIP_TMP_DIR=/tmp/pip_tmp_install


RUN apt clean \
    && apt -y update \
    && apt -y install git \
    && apt -y install python3.7 python3.7-dev

# We want to install pip just for python 3.7 but pip3 will also install python3.6 in the system and we don't want that
RUN apt -y  install curl \
    && mkdir ${PIP_TMP_DIR} && cd ${PIP_TMP_DIR} \
    && apt download python3-distutils \
    && dpkg-deb -x python3-distutils_3.6.9-1~18.04_all.deb . \
    && cp -r usr/lib/python3.7 /usr/lib \
    && curl https://bootstrap.pypa.io/get-pip.py | python3.7 \
    && cd \
    && rm -rf ${PIP_TMP_DIR}

# We want to canonicalize `python` and `pip` to point to this specific python version
RUN ln -s /usr/bin/python3.7 /usr/bin/python
