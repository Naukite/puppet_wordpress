class wordpress {
  file {'/srv/www': 
    ensure => 'directory',
    owner => 'www-data',
    group => 'www-data',
    require => [Package[$apachelibs, $ghostscriptlibs, $mysqllibs, $phplibs]]
  } 

  exec{'get_wordpress':
    command => "/usr/bin/curl https://wordpress.org/latest.tar.gz | /usr/bin/sudo -u www-data /usr/bin/tar zx -C /srv/www",
    require => File['/srv/www']
  }

  file { '/etc/apache2/sites-available/wordpress.conf':
    content => template('wordpress/wordpress.conf.erb'),
    owner => 'www-data',
    group => 'www-data',    
    require => Exec['get_wordpress'],
  }

  exec{'enable_wordpress':
    command => "/usr/bin/sudo /usr/sbin/a2ensite wordpress && /usr/bin/sudo /usr/sbin/a2enmod rewrite && /usr/bin/sudo /usr/sbin/a2dissite 000-default && /usr/bin/sudo /usr/bin/systemctl restart apache2",
    require => File['/etc/apache2/sites-available/wordpress.conf']
  }  

  exec{'create_db_wordpress':
    command => "/usr/bin/sudo /usr/bin/mysql -e \"CREATE USER wordpress@localhost IDENTIFIED BY 'strongpassword';CREATE DATABASE wordpress;GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;FLUSH PRIVILEGES;\"",
    require => Exec['enable_wordpress']
  }  

  service { 'mysql':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/bin/sudo /usr/sbin/service mysql restart",
    require => Exec['create_db_wordpress']
  }  

  file { '/srv/www/wordpress/wp-config.php':
    content => template('wordpress/wp-config.php.erb'),
    owner => 'www-data',
    group => 'www-data',    
    require => Exec['create_db_wordpress']
  }  

  file { '/vagrant/script.sql':
    content => template('wordpress/script.sql.erb'),  
    require => Exec['create_db_wordpress']
  }    

  exec{'config_final_wordpress':
    command => "/usr/bin/sudo /usr/bin/mysql -h localhost wordpress < /vagrant/script.sql",
    require => File['/vagrant/script.sql'],
    timeout => 0,
    logoutput => true
  }    
}

