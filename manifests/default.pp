$apachelibs = ['apache2', 'libapache2-mod-php']
$ghostscriptlibs = ['ghostscript']
$mysqllibs = ['mysql-server']
$phplibs = ['php', 'php-bcmath', 'php-curl',  'php-imagick', 'php-intl', 'php-json', 
            'php-mbstring', 'php-mysql', 'php-xml', 'php-zip']
include updater
include apache
include php
include mysql
include ghostscript
include wordpress


notify { '[Box says] I will tell you something about me: ':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s.
              Please check access to http://$::ipaddress_enp0s8}",
}
