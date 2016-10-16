class redmine::web::service inherits params {

  service {'Starting httpd service':
    ensure   => "${http_ensure}",
    name     => "${http_name}",
  }
}
