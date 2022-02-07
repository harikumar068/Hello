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

# Create Config file
RUN echo [default] >> config
RUN echo region = us-east-1 >> config
RUN echo output = json >> config

# Create credentials file
RUN echo [default] >> credentials
RUN echo aws_access_key_id = ******************* >> credentials
RUN echo aws_secret_access_key = qEdXP/hAxeuhbluyU9wKohaOJqnHyveA6/YZu/Ui >> credentials

# Working directory
WORKDIR /usr/src/myapp

# Change directory
RUN cd /usr/src/myapp

# Cloning GIT Repo
RUN git clone https://github.com/navchait/Hello.git

# Copying file from Hello 
RUN cp /usr/src/myapp/Hello/main.c /usr/src/myapp/main.c

# Compiling the C Program
RUN gcc -o myapp main.c

# Upload file to S3 Bucket
RUN aws s3 cp myapp s3://20211203001

# Using the ubuntu Base Image
FROM ubuntu:latest

# MAINTAINER NAME
LABEL maintainer "Harikumar RS"

# Configuring tzdata
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install AWSCLI 
RUN apt-get update \
   && apt-get install python3 -y \
   && apt-get install python3-pip -y \
   && apt-get install awscli -y

# Copying the Files
COPY . /usr/hello

# Working directory
WORKDIR /usr/hello

RUN cd ~ \
    && mkdir .aws \
    && chmod 755 .aws \
    && cd .aws

# Working directory
WORKDIR /root/.aws

# Create Config file
RUN echo [default] >> config
RUN echo region = us-east-1 >> config
RUN echo output = json >> config

# Create credentials file
RUN echo [default] >> credentials
RUN echo aws_access_key_id = ******************* >> credentials
RUN echo aws_secret_access_key = qEdXP/hAxeuhbluyU9wKohaOJqnHyveA6/YZu/Ui >> credentials

# Working directory
WORKDIR /usr/hello

# Change directory
RUN cd /usr/hello

# Download Output
RUN aws s3 cp s3://20211203001/myapp /usr/hello/./myapp

# Changing file access
RUN chmod 755 myapp

# Output
CMD ["./myapp"]
