# This file is generated from a template. 
# Any edit will be lost when regenerating it.

FROM ubuntu:18.04

# Install everything we need from APT and clean the cache.
RUN apt -y update \
    && apt -y install build-essential curl git mysql-client python3.8 python3.8-dev \
    && apt clean

# We want to install pip just for python 3.8
ARG PIP_TMP_DIR=/tmp/pip_tmp_install
RUN mkdir ${PIP_TMP_DIR} \
    && cd ${PIP_TMP_DIR} \
    && apt download python3-distutils \
    && dpkg-deb -x python3-distutils_*.deb . \
    && cp -r usr/lib/python3.8 /usr/lib \
    && curl https://bootstrap.pypa.io/get-pip.py | python3.8 \
    && cd \
    && rm -rf ${PIP_TMP_DIR}

# Disable the Pip cache, as we don't reuse it inside Docker.
# This saves a couple MBs and keeps the image cleaner.
ENV PIP_NO_CACHE_DIR=0

# We want to canonicalize `python` and `pip` to point to this specific python version
RUN ln -s /usr/bin/python3.8 /usr/bin/python
