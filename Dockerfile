# INSTALL UBUNTU
FROM node:6

LABEL maintainer="Mauricio Sanchez <msanchez@aplyca.com>" \
      description="Node.js image with Oracle instant client"

#INSTALL LIBAIO1 & UNZIP (NEEDED FOR STRONG-ORACLE)
RUN apt-get update \
  && apt-get install -y libaio1 \
  && apt-get install -y build-essential \
  && apt-get install -y unzip \
  && apt-get install -y curl

#ADD ORACLE INSTANT CLIENT
RUN mkdir -p opt/oracle
ADD instantclient*.zip ./

RUN unzip instantclient-basic-linux.x64-11.2.0.4.0.zip -d /opt/oracle \
  && unzip instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /opt/oracle  \
  && mv /opt/oracle/instantclient_11_2 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.11.1 /opt/oracle/instantclient/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.11.1 /opt/oracle/instantclient/libocci.so

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig
