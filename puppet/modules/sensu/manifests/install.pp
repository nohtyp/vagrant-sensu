class sensu::install inherits sensu {
  
  package { $sensu_package:
    ensure  => installed,
    require => Class['profile::myrepo'],
  }
}
