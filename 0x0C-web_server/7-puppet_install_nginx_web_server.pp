# configure nginx
package { 'nginx':
  ensure => installed,
}

# Configure Nginx server
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        location / {
            return 200 "Hello World!";
        }

        location /redirect_me {
            return 301 http://example.com/redirected_page;
        }
    }
  ',
  notify  => Service['nginx'],
}

# Set up custom 404 error page
file { '/var/www/html/404.html':
  ensure  => file,
  content => '
    <!DOCTYPE html>
    <html>
    <head>
        <title>Error 404 - Not Found</title>
    </head>
    <body>
        <h1>Error 404 - Not Found</h1>
        <p>Ceci n\'est pas une page.</p>
    </body>
    </html>
  ',
}

# Configure Nginx to use custom 404 error page
file { '/etc/nginx/nginx.conf':
  ensure  => present,
  content => "
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    error_page 404 /404.html;

    # rest of nginx.conf configuration...
  ",
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  restart   => '/bin/systemctl reload nginx',
}
