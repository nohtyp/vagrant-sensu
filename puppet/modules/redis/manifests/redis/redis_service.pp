class redis::redis::redis_service inherits redis {

  service {'Redis Service':
    ensure     => running,
    name       => $::redis::redis_service,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$::redis::redis_package],
    subscribe  => File['Redis Service config'],
  }
}
