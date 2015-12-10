class sensu::uchiwa::uchiwa_service inherits sensu {

  service {'Sensu Uchiwa Service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'uchiwa',
    subscribe     => File['uchiwa config'],
  }
} 

