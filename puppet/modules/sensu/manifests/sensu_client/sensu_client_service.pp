class sensu::sensu_client::sensu_client_service inherits sensu {

  service {'Sensu Client service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'sensu-client',
  }
}
