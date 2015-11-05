class myfirewall::config inherits myfirewall {

  myfirewall { 'Sensu Rule':
    ensure     => absent,
    zone       => 'public',
    richrule   => 'rule family="ipv4" source address="192.168.0.0/24" service name="http" accept',
    permanent  => true,
   }
}
