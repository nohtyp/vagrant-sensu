class httpd::service inherits params {

  service {'Starting httpd service':
    ensure   => running,
    name     => 'httpd',
  }
}
