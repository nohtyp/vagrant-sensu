class sensu::uchiwa::uchiwa_service inherits sensu {

  service {'Starting Uchiwa service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'uchiwa',
  }
}
