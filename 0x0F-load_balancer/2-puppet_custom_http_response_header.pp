# creating a custum HTTP header response with Puppet

exec { 'command':
  command  => 'apt-get update;
  apt-get install nginx -y;
  sudo sed -i '24i\\n\tadd_header X-Served-By $hostname;' /etc/nginx/sites-available/default
  sudo service nginx restart',
  provider => shell,
}
