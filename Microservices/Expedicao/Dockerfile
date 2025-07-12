#FROM ubuntu:16.04
FROM ubuntu:22.04

LABEL maintainer="genilson@rhemasys.com.br"

RUN \ 
 apt-get -y update
# configurar o timezone
RUN \ 
 apt-get -y install tzdata && \
 ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
 dpkg-reconfigure -f noninteractive tzdata 

#  bibliotecas adicionais
RUN \
 apt-get -y upgrade && \
 apt-get -y dist-upgrade && \
 apt-get -y install joe wget p7zip-full curl unzip build-essential zlib1g-dev libcurl4-gnutls-dev && \
 apt-get -y install mysecureshell 


RUN \
 apt-get install -y curl && \
 apt-get install -y apt-transport-https && \
 apt-get install -y unixodbc-dev && \
 curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
 curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
 apt-get update && \
 ACCEPT_EULA=Y apt-get -q -y install msodbcsql17

RUN \ 
 apt-get -y autoremove && \
 apt-get -y autoclean 

WORKDIR /root
COPY bin bin
# Comandos no container

CMD cd bin;chmod +x ./MicroservicesExpedicao ; ./MicroservicesExpedicao
# portas
EXPOSE 8200