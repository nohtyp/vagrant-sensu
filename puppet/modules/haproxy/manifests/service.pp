class haproxy::service inherits params {

  service { 'haproxy service':
    ensure  => running,
    name    =>  'haproxy',
    require => Package['haproxy'],
 }
}
