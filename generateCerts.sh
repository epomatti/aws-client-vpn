#!/bin/bash

certsDirectory=$PWD/certs
mkdir $certsDirectory

cd easy-rsa/easyrsa3

./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full client1.domain.tld nopass

cp pki/ca.crt $certsDirectory
cp pki/issued/server.crt $certsDirectory
cp pki/private/server.key $certsDirectory
cp pki/issued/client1.domain.tld.crt $certsDirectory
cp pki/private/client1.domain.tld.key $certsDirectory/
