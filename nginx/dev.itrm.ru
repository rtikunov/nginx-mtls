upstream dev2 {
  server dev2.itrm.ru:443;
}

server {
  listen 443 ssl http2;
  server_name  dev.itrm.ru;
  include      /etc/nginx/ssl/ssl.conf;

  error_log       /var/log/nginx/dev.itrm.ru-error.log;
  access_log      /var/log/nginx/dev.itrm.ru-access.log upstream;

  location / {
    proxy_pass        https://dev2;
    proxy_ssl_certificate /etc/nginx/ssl/client.pem;
    proxy_ssl_certificate_key /etc/nginx/ssl/client-key.pem;
    proxy_ssl_trusted_certificate /etc/nginx/ssl/ca.pem;
    proxy_ssl_protocols TLSv1.2 TLSv1.3;
  }
}

