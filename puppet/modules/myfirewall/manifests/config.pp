class myfirewall::config inherits myfirewall {

  myfirewall { 'Sensu firewall port':
    ensure     => present,
    zone       => 'public',
    port       => $myports,
    protocol   => 'tcp',
    notify     =>  Exec['Reloading firewall rules'],
   }
}
