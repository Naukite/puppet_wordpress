include updater
include apache
include php
include mysql
include ghostscript

notify { '[Box says] I will tell you something about me: ':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s.
              Please check access to http://$::ipaddress_enp0s8}",
}
