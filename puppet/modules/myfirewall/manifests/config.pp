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
    tcp_udp    => $myproto,
    notify     =>  Exec['Reloading firewall rules'],
   }
}
