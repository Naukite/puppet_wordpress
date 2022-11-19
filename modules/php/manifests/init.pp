class php {
  $phplibs = ['php', 'php-bcmath', 'php-curl',  'php-imagick', 'php-intl', 'php-json', 
              'php-mbstring', 'php-mysql', 'php-xml', 'php-zip']
              
  package { $phplibs:
    ensure => installed,
  }
}

