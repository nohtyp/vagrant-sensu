class postgresql::install inherits params {

  package { $postgresql_packages:
    ensure  => $postgresql_package_ensure,
  }
}
