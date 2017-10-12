#!/bin/bash
# Download oracle 
set -ex

yum install oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
yum install oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm

ROOTDIR="/home/vcap/app"
BINDIR=$ROOTDIR
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-basic-linux.x64-12.2.0.1.0.zip" -P $BINDIR
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-sdk-linux.x64-12.2.0.1.0.zip" -P $BINDIR
# Install oracle
cd $BINDIR
unzip instantclient-basic-linux.x64-12.2.0.1.0.zip
unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip
mv instantclient_12_2 instantclient
cd instantclient
cp libclntsh.so.12.1 libclntsh.so
# ln -s libclntsh.so.12.1 libclntsh.so
export LD_LIBRARY_PATH=$PWD:
export OCI_LIB_DIR=$PWD
export OCI_INC_DIR=$PWD/sdk/include
echo $OCI_LIB_DIR
echo $OCI_INC_DIR