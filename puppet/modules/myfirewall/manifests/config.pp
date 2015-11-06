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
    protocol   => 'tcp',
    port       => '1534',
    notify     =>  Exec['Reloading firewall rules'],
   }
}
