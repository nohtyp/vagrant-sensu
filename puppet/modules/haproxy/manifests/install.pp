class haproxy::install inherits params {

  package { 'haproxy':
    ensure => present,
    name   => 'haproxy',
  }
}
