# creating a custum HTTP header response with Puppet

exec { 'update_system':
        command => '/usr/bin/apt-get update',
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update_system']
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

exec {'add_header':
	command => 'sed -i "24i\	add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}
