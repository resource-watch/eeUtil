FROM python:3.7 as user
MAINTAINER Vizzuality Science Team info@vizzuality.com

RUN pip install --upgrade pip
ARG HOST_UID=${HOST_UID:-4000}
ARG HOST_USER=nodummy
COPY . .
RUN pip install -r requirements.txt
RUN useradd -ms /bin/bash ${HOST_USER} 

USER ${HOST_USER}
WORKDIR /home/${HOST_USER}

COPY files/profile .profile


