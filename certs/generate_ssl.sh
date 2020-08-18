cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=mtls mtls-csr.json | cfssljson -bare server
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=mtls mtls-csr.json | cfssljson -bare client
