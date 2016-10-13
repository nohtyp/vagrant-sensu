class httpd::install inherits params {

  package { $httpd_packages:
    ensure   => installed,
  }
}
