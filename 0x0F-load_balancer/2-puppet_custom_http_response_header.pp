# Puppet manifest to configure Nginx with custom HTTP header X-Served-By

# Ensure Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Configure Nginx with custom header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    add_header X-Served-By ${hostname};

    location / {
        try_files \$uri \$uri/ =404;
    }
}",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}