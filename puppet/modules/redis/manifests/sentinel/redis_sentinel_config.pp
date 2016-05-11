class redis::sentinel::redis_sentinel_config inherits redis {

  file { 'Redis Sentinel config':
    ensure  => file,
    path    => $::redis::redis_sentinel_config_path,
    backup  => true,
    mode    => '0644',
    owner   => $::redis::redis_user,
    group   => $::redis::redis_group,
    content => template('redis/redis_sentinel_config.erb'),
  }
}
