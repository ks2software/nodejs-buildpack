#!/usr/bin/env bash
set -ex

ROOTDIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" )"
BINDIR=$ROOTDIR/bin

export GOPATH=$ROOTDIR
export GOOS=linux

go build -ldflags="-s -w" -o $BINDIR/supply nodejs/supply/cli
go build -ldflags="-s -w" -o $BINDIR/finalize nodejs/finalize/cli

# Save current path?
MYPATH=$PWD

# Download oracle 
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-basic-linux.x64-12.2.0.1.0.zip" -P $BINDIR
wget --no-check-certificate --no-proxy "https://s3.amazonaws.com/cityofdenton-lib/instantclient-sdk-linux.x64-12.2.0.1.0.zip" -P $BINDIR

# Install oracle
cd $BINDIR
unzip instantclient-basic-linux.x64-12.2.0.1.0.zip
unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip
mv instantclient_12_2 instantclient
cd instantclient
ln -s libclntsh.so.12.1 libclntsh.so
export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
export OCI_LIB_DIR=$PWD
export OCI_INC_DIR=$PWD/sdk/include
echo $OCI_LIB_DIR
echo $OCI_INC_DIR
cd $MYPATH