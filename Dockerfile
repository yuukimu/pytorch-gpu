FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ENV LANG=C.UTF-8

RUN apt-get update -y
RUN apt-get install -yq make cmake gcc g++ unzip wget build-essential gcc zlib1g-dev\
    libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev

# Python3のインストール
WORKDIR /root/
ENV PYTHONIOENCODING "utf-8"
RUN wget https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz \
        && tar zxf Python-3.6.7.tgz \
        && cd Python-3.6.7 \
        && ./configure \
        && make altinstall
RUN apt-get install -y python3-pip python-qt4

RUN echo "alias python='python3.6'" > ~/.bashrc && \
    echo "alias pip='pip3.6'" >> ~/.bashrc && \
    . ~/.bashrc

RUN pip3.6 install --upgrade pip

ADD requirements.txt /root/
RUN pip3.6 install -r requirements.txt

ENV APP_NAME torch
WORKDIR /home/$APP_NAME

CMD '/bin/bash'
