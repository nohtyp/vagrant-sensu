class myfirewall::config inherits myfirewall {

  myfirewall { 'Second richrule':
    ensure     => present,
    zone       => 'public',
    port       => $myports,
    protocol   => 'tcp',
    notify     =>  Exec['Reloading firewall rules'],
   }
}
