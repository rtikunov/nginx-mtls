server {
  listen 443 ssl http2;
  server_name  dev2.itrm.ru;

  error_log       /var/log/nginx/dev2.itrm.ru-error.log;
  access_log      /var/log/nginx/dev2.itrm.ru-access.log;

  include      /etc/nginx/ssl/ssl.conf;

  ssl_verify_client on;
  ssl_verify_depth 10;
  ssl_client_certificate /home/rodion/ssl/ca.pem;

  # Output of the command:
  # openssl x509 -in client.pem -noout -fingerprint | cut -d= -f2 | sed 's/://g' | tr '[:upper:]' '[:lower:]'
  if ($ssl_client_fingerprint != "changeme") {
     return 403;
  }

  root /usr/local/nginx/html;
}
