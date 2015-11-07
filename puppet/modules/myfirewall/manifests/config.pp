class myfirewall::config inherits myfirewall {

  #myfirewall { 'First richrule':
  #  ensure     => absent,
  #  zone       => 'public',
  #  richrule   => $myrichrule,
  #  permanent  => true,
  # }
  myfirewall { 'Second richrule':
    ensure     => absent,
    zone       => 'public',
    port       => $myport,
    protocol   => 'tcp',
    notify     =>  Exec['Reloading firewall rules'],
   }
}
