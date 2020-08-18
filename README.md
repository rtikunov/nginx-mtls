Nginx mTLS configuration on Ubuntu 18.04

1. Install `golang-cfssl` package:
> apt install golang-cfssl
2. Generate TLS certificates:
> cd certs
> ./generate_ssl.sh
3. Copy `*.pem` certificates on your web-servers:
> rsync *.pem dev:/etc/nginx/ssl/
> rsync *.pem dev2:/etc/nginx/ssl/
4. Copy ssl.conf file on your web-servers:
> rsync nginx/ssl.conf dev2:/etc/nginx/ssl/
5. Get client sertificate's fingerpring:
> FP=`openssl x509 -in client.pem -noout -fingerprint | cut -d= -f2 | sed 's/://g' | tr '[:upper:]' '[:lower:]'`
6. Change client certificate's fingerpring with your own:
> sed -i "s/changeme/${FP}/" nginx/dev2.itrm.ru
7. Copy server's config files on appropriate web-servers:
> rsync nginx/dev.itrm.ru dev.itrm.ru:/etc/nginx/sites-enabled/
> rsync nginx/dev2.itrm.ru dev2.itrm.ru:/etc/nginx/sites-enabled/
8. Reload nginx daemons on both servers:
> systemctl nginx reload
9. Try to connect to dev2.itrm.ru server without client cert:
> curl --cacert /etc/nginx/ssl/ca.pem  -I https://dev2.itrm.ru
Answer: HTTP/2 400
10. Try to connect to dev2.itrm.ru server with unappropriate client cert:
> curl --cacert /etc/nginx/ssl/ca.pem --cert /etc/nginx/ssl/mtls.pem --key /etc/nginx/ssl/mtls-key.pem -I https://dev2.itrm.ru
Answer: HTTP/2 403
11. Try to connect to dev2.itrm.ru server with the appropriate client cert:
> curl --cacert /etc/nginx/ssl/ca.pem --cert /etc/nginx/ssl/client.pem --key /etc/nginx/ssl/client-key.pem -I https://dev2.itrm.ru
Answer: HTTP/2 200
