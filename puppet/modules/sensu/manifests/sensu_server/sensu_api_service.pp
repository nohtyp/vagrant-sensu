class sensu::sensu_server::sensu_api_service inherits sensu {

  service {'Sensu API Service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'sensu-api',
  }
} 

