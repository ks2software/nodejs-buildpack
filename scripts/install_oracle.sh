#!/bin/bash
# Download oracle 
set -ex
ROOTDIR="/home/vcap/deps"

export BUILDPACK_DIR=`dirname $(readlink -f ${BASH_SOURCE%/*})`
cd $BUILDPACK_DIR/libaio
make prefix=$ROOTDIR install
ls -la

BINDIR=$ROOTDIR
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-basic-linux.x64-12.2.0.1.0.zip" -P $BINDIR
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-sdk-linux.x64-12.2.0.1.0.zip" -P $BINDIR
# Install oracle
cd $BINDIR
unzip -q instantclient-basic-linux.x64-12.2.0.1.0.zip
unzip -q instantclient-sdk-linux.x64-12.2.0.1.0.zip
mv instantclient_12_2 instantclient
cd instantclient
cp libclntsh.so.12.1 libclntsh.so
# ln -s libclntsh.so.12.1 libclntsh.so
export LD_LIBRARY_PATH=$ROOTDIR:
export OCI_LIB_DIR=$PWD
export OCI_INC_DIR=$PWD/sdk/include
echo $OCI_LIB_DIR
echo $OCI_INC_DIR