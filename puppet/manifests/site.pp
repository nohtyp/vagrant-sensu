node 'test.familyguy.local' { 
  class {'role::sensu_server':}
}
node 'test02.familyguy.local' { 
  class {'role::sensu_client':}
}
node 'test03.familyguy.local' { 
  class {'role::sensu_server':}
}
