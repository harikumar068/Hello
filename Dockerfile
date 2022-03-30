# Using the ubuntu Base Image
FROM ubuntu:latest

# MAINTAINER NAME
LABEL maintainer "Harikumar RS"

# Configuring tzdata
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install GCC
RUN apt-get update \
   && apt-get install gcc -y \
   && apt-get install git -y \
   && apt-get install python3 -y \
   && apt-get install python3-pip -y \
   && apt-get install awscli -y
   
# Copying the Files
COPY . /usr/src/myapp

# Working directory
WORKDIR /usr/src/myapp

# Changing Directory & Configuring AWSCLI
RUN cd ~ \
    && mkdir .aws \
    && chmod 755 .aws \
    && cd .aws
	
# Working directory
WORKDIR /root/.aws
