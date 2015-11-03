class myfirewall::config inherits myfirewall {

  firewall { 'Firewall Test':
    ensure    => present,
    name      => 'public',
    zone      => 'public',
    service   => 'https',
    permanent => false,
   }
}
