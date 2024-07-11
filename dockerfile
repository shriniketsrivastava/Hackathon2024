FROM hashicorp/tfc-agent:latest
USER root
RUN cd /opt
RUN mkdir packer_new
RUN cd packer_new
RUN wget https://releases.hashicorp.com/packer/1.11.1/packer_1.11.1_linux_amd64.zip
RUN apt-get install -y unzip
RUN unzip -o packer_1.11.1_linux_amd64.zip
RUN ./packer --version
