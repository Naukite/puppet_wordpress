class updater {
  exec { 'apt-update-upgrade':
    command => '/usr/bin/apt-get update && /usr/bin/apt-get upgrade -y'
  }
  Exec["apt-update-upgrade"] -> Package <| |>
}

