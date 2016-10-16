class redmine::web::service inherits params {

  service {'Starting httpd service':
    #ensure   => running,
    ensure   => "${http_ensure}",
    #name     => 'httpd',
    name     => "${http_name}",
  }
}
