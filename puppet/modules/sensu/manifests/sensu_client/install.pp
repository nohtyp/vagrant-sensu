class sensu::sensu_client::install inherits sensu {
  
  package { $sensu_client_package:
    ensure  => installed,
  }
}
