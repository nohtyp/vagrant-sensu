class sensu::sensu_server::sensu_server_service inherits sensu {

  service {'Sensu Server Service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'sensu-server',
    subscribe     => Service['Sensu API Service'],
  }
} 
