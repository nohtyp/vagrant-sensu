node 'sensu.familyguy.local' { 
#  class {'role::myproxy':}
}
node 'sensu01.familyguy.local' { 
#  class {'role::sensu_server':}
}
node 'sensuclient01.familyguy.local' { 
#  class {'role::sensu_client':}
}
node 'sensu02.familyguy.local' { 
#  class {'role::sensu_server':}
}
#node 'test.familyguy.local' { 
#  class {'role::mywiki':}
#}
node 'influxdb01.familyguy.local' { 
  class {'role::mydns':}
}
node 'influxdb02.familyguy.local' { 
#  class {'role::mydns':}
}
node 'influxdb03.familyguy.local' { 
#  class {'role::mydns':}
}
