#!/usr/bin/env bash
set -e

cd ~/tmp

wget -c http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p195.tar.gz
tar xzf ruby-2.0.0-p195.tar.gz
cd ruby-2.0.0-p195
 
./configure
make
 
sudo checkinstall -y \
  --pkgversion 2.0.0-p195 \
  --provides "ruby-interpreter"
