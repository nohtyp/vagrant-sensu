class sensu::sensu_server::install inherits sensu {
  
  package { $sensu_package:
    ensure  => installed,
    #require => Class['profile::myrepo'],
  }
}
