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
    richrule   => $myrichrule1,
    permanent  => true,
    #require    => Myfirewall['First richrule']
    notify     =>  Exec['Reloading firewall rules'],
   }
}
