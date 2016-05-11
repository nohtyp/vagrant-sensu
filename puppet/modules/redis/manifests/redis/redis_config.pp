class redis::redis::redis_config inherits redis {

  file { 'Redis Service config':
    ensure  => file,
    path    => $::redis::redis_config_path,
    #backup  => true,
    mode    => '0644',
    owner   => $::redis::redis_user,
    group   => $::redis::redis_group,
    require => Package[$::redis::redis_package],
    content => template('redis/redis_config.erb'),
  }
}
