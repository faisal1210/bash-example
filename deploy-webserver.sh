#!/bin/bash
##### INSTALL NGINX, PHP MODULE & GIT ######
sudo apt update -y
sudo apt install -y nginx php-fpm php-mysqli git
##### CONFIGURE NGINX ######
sudo tee /etc/nginx/sites-available/sosmed <<EOF
server {
        listen 80;
        root /var/www/html;
        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html;
        server_name localhost;        
        location / {
		index index.php index.html index.htm;
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files \$uri \$uri/ =404;
        }
        location ~ \.php$ {
          include snippets/fastcgi-php.conf;
          fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }
}
EOF
sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/sosmed /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl restart php7.2-fpm
##### CLONE WEB APPS DATA FROM GITHUB (don't forget modify config.php) ######
cd /var/www/html/
sudo git clone https://github.com/faisal1210/sosial-media.git
sudo mv sosial-media/* . && sudo mv sosial-media/.git . && sudo rm -rf sosial-media/
