#!/usr/bin/env bash
# Configure server using puppet

# defines a Puppet class called nginx_server that 
#  encapsulates the configuration for the Nginx server.
class nginx_server {
  package { 'nginx':
    ensure => installed,
  }

#  manages the Nginx service.
  service { 'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => present,
    content => "
      server {
        listen      80 default_server;
        listen      [::]:80 default_server;
        root        /var/www/html;
        index       index.html index.htm;

        location / {
          return 200 'Hello World!';
        }

        location /redirect_me {
          return 301 http://cuberule.com/;
        }
      }
    ",
    notify => Service['nginx'],
  }
}

include nginx_server