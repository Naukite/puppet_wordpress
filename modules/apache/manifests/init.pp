class apache {
  $apachelibs = ['apache2', 'libapache2-mod-php']
  package { $apachelibs:
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
  }
}

