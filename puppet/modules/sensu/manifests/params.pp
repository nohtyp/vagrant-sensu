class sensu::params {

$sensu_base_url          = 'http://repos.sensuapp.org/yum/el/$releasever/$basearch/'
$epel_url                = 'http://dl.fedoraproject.org/pub/epel/7/x86_64/'
$gempackages             = ['sensu-plugin']
$sensu_package           = ['sensu', 'rubygems', 'uchiwa']
$sensu_client_package    = ['sensu', 'rubygems']
$use_sensu_repo          = true
$sensu_client            = false
$sensu_config_path       = '/etc/sensu/config.json'
$sensu_uchiwa_path       = '/etc/sensu/uchiwa.json'
$sensu_client_path       = '/etc/sensu/conf.d/client.json'
$rabbitmq_host           = 'test.familyguy.local'
$rabbitmq_port           = 5672
$rabbitmq_user           = 'sensu'
$rabbitmq_pw             = 'sensu'
$rabbitmq_vhost          = '/sensu'
$redis_port              = 6379
$redis_host              = 'test.familyguy.local'
$sensu_api_host          = 'test.familyguy.local'
$sensu_api_port          = 4567
$sensu_sites             = [ { name => 'Site 1', host => 'test.familyguy.local', port => 4567, timeout => 5 },
                             { name => 'Site 2', host => 'test03.familyguy.local', port => 4567, timeout => 5 },
                           ]
$sensu_subscriptions     = [ 'test', 'foster' ]
$uchiwa_host             = '0.0.0.0'
$uchiwa_port             = 3000
$uchiwa_interval         = 5
$uchiwa_server           = false
}
