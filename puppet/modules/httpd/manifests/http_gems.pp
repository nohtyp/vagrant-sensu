class httpd::http_gems inherits params {

  package { $httpd_gems:
    ensure   => installed,
    provider => 'gem',
  }
}
