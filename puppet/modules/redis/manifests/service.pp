class redis::service inherits redis {

  service { $redis_service:
    ensure        => running,
    name          => $redis_service,
    enable        => true,
    hasrestart    => true,
    hasstatus     => true,
    
  }
}
