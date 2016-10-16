class redmine::openssl::create_certificate inherits params {

  exec { 'Creating OpenSSL certificate':
    path    => '/bin',
    #command => "openssl req -new -newkey rsa:${rsa_strength} -days ${rsa_days} -nodes -x509 -subj ${openssl_cert} \
    command => "openssl req -new -newkey rsa:${rsa_strength} -days ${rsa_days} -nodes -x509 -subj ${openssl_cert} \
                -keyout ${openssl_keyout} -out ${openssl_certout}",
    unless  => ["test -f ${openssl_keyout}", "test -f ${openssl_certout}"],
  }
}
