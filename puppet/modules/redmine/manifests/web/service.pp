class redmine::web::service inherits params {

  service {'Starting httpd service':
    ensure   => running,
    name     => 'httpd',
  }
}
