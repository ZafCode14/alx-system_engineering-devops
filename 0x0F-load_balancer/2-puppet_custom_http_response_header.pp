# creating a custum HTTP header response with Puppet
#
exec { 'update_apt':
  command   => 'apt-get update',
  provider  => shell,
  logoutput => true,
}

exec { 'install_nginx':
  command   => 'apt-get install nginx -y',
  provider  => shell,
  require   => Exec['update_apt'],
  logoutput => true,
}

exec { 'add_header':
  command   => "sudo sed -i '24i\\n\tadd_header X-Served-By $hostname;' /etc/nginx/sites-available/default",
  provider  => shell,
  require   => Exec['install_nginx'],
  logoutput => true,
}

exec { 'restart_nginx':
  command   => 'service nginx restart',
  provider  => shell,
  require   => Exec['add_header'],
  logoutput => true,
}
