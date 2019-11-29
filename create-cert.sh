#!/bin/bash -x

# directories
ca_cert_dir="./ca-cert"
server_cert_dir="./server-cert"
client_cert_dir="./client-cert"
# common names
ca_common_name="SELF SIGNED CA"
server_common_name="localhost"
client_common_name="user"


# create directories
mkdir -p ${ca_cert_dir}
mkdir -p ${server_cert_dir}
mkdir -p ${client_cert_dir}


# create ca certificate
openssl genrsa 4096 > ${ca_cert_dir}/ca.key
openssl req -new -key ${ca_cert_dir}/ca.key -subj "/CN=${ca_common_name}/C=JP" > ${ca_cert_dir}/ca.csr
openssl x509 -req -in ${ca_cert_dir}/ca.csr -signkey ${ca_cert_dir}/ca.key -days 3650 -out ${ca_cert_dir}/ca.crt 

# create server certificate
openssl genrsa 4096 > ${server_cert_dir}/server.key
openssl req -new -key ${server_cert_dir}/server.key -subj "/CN=${server_common_name}/C=JP" > ${server_cert_dir}/server.csr
openssl x509 -req -in ${server_cert_dir}/server.csr -CA ${ca_cert_dir}/ca.crt -CAkey ${ca_cert_dir}/ca.key -CAcreateserial -days 3650 -out ${server_cert_dir}/server.crt

# create client certificate
openssl genrsa 4096 > ${client_cert_dir}/client.key
openssl req -new -key ${client_cert_dir}/client.key -subj "/CN=${client_common_name}/C=JP" > ${client_cert_dir}/client.csr
openssl x509 -req -in ${client_cert_dir}/client.csr -CA ${ca_cert_dir}/ca.crt -CAkey ${ca_cert_dir}/ca.key -CAcreateserial -days 3650 -out ${client_cert_dir}/client.crt


# created files
echo '####################'
ls ${ca_cert_dir}/
ls ${server_cert_dir}/
ls ${client_cert_dir}/
