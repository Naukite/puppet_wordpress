class nginx {
  package { 'nginx':
    ensure => installed,
    require => Exec['config_final_wordpress']    
  }

  file { '/etc/nginx/nginx.conf':
    content => template('nginx/nginx.conf.erb'),    
    require => Package['nginx']
  }


  service { 'nginx':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/bin/sudo  /usr/bin/systemctl restart nginx && /usr/bin/sudo nginx -s reload",
    require => Package['nginx']
  }  
}

