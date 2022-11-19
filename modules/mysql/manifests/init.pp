class mysql {
  package { 'mysql-server':
    ensure => installed,
  }
}

