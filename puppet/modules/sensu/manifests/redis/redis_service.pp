class sensu::redis::redis_service inherits sensu {

  service {'Starting Redis service':
    ensure        => running,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    name          => 'redis',
  }
}
