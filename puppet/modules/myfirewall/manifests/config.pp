class myfirewall::config inherits myfirewall {

  firewall { 'Sensu Rule':
    ensure     => present,
    name       => 'public',
    zone       => 'public',
    port       => '3000',
    protocol   => 'tcp',
    permanent  => true,
   }
}
