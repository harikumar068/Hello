# Using the ubuntu Base Image
FROM ubuntu:latest

# MAINTAINER NAME EMAIL
LABEL maintainer "Harikumar RS"

# Install GCC
RUN apt-get update \
   && apt-get install gcc -y \
   && apt-get install git -y

# Copying the Files
COPY . /usr/src/myapp

# Working directory
WORKDIR /usr/src/myapp

# Cloning GIT Repo
RUN git clone https://github.com/navchait/Hello.git

# Copying main.c file
RUN cp /usr/src/myapp/Hello/main.c /usr/src/myapp/main.c

# Compiling the C Program
RUN gcc -o myapp main.c

# Copying output to Local Machine
# COPY /usr/src/myapp/./myapp /home/ubuntu/test/

# Using the ubuntu Base Image
# FROM ubuntu:latest

# MAINTAINER NAME EMAIL
# LABEL maintainer "Harikumar RS"

# Copying the Files
# COPY . /usr/src/myapp

# Working directory
# WORKDIR /usr/src/myapp

# Copying output to container
# COPY /home/ubuntu/test/./myapp /usr/src/myapp

# Output in Seperate Directory
# CMD ["./myapp"]
