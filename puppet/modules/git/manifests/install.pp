class git::install inherits git {

  package { 'install git':
    ensure => present,
    name   => 'git',
  }
}
