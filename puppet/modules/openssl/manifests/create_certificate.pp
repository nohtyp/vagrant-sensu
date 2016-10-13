class openssl::create_certificate inherits params {

  exec { 'Creating OpenSSL certificate':
    path    => '/bin',
    command => "openssl req -new -newkey rsa:4096 -days 3653 -nodes -x509 -subj /C=US/ST=Maryland/L=Suitland/O=NOAA/OU=GRAVITE/CN=fts02test \
                -keyout /etc/pki/tls/private/fts02test.key -out /etc/pki/tls/private/fts02test.cert",
    unless  => ['test -f /etc/pki/tls/private/fts02test.key', 'test -f /etc/pki/tls/private/fts02test.cert'],
  }
}
