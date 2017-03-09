#!/bin/bash
#
# Roughly follows:
#
# https://github.com/HDFGroup/H5Tuner/wiki/Example

set -e

echo "Installing a few things via package manager, just to be sure."
sudo apt-get install -y libmxml-dev

echo "Installing zlib"
wget http://zlib.net/zlib-1.2.11.tar.gz
tar xvzf zlib-1.2.11.tar.gz
pushd zlib-1.2.11
./configure --prefix=/usr
make -j 4 && sudo make install
popd


echo "Installing hdf5"
wget https://support.hdfgroup.org/ftp/HDF5/current18/src/hdf5-1.8.18.tar.gz
tar xvzf hdf5-1.8.18.tar.gz
pushd hdf5-1.8.18
CC=mpicc FC=mpif90 CXX=mpic++ ./configure --prefix=/usr --enable-parallel --with-zlib=/usr --enable-hl --enable-shared --disable-static --enable-using-memchecker --enable-debug=all --enable-codestack
make -j 4 && sudo make install
popd