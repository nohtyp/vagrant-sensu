class redis::sentinel::redis_sentinel_service inherits redis {

  service {'Redis Sentinel Service':
    ensure     => running,
    name       => $::redis::redis_sentinel_service,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$::redis::redis_package],
    subscribe  => File['Redis Sentinel config'],
  }
}
