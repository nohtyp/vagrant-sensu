class redmine::install inherits params {
  package { $redmine_packages:
    ensure => present,
  }
}
