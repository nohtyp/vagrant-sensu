class haproxy::config inherits params {

  file { 'Configure haproxy file':
      ensure  => file,
      path    =>  '/etc/haproxy/haproxy.cfg',
      backup  => true,
      content => template('haproxy/haproxy_config.erb'),
      require => Package['haproxy'],
  }
}
