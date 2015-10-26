class sensu::params {

$sensu_base_url   = 'http://repos.sensuapp.org/yum/el/$releasever/$basearch/'
$epel_url         = 'http://dl.fedoraproject.org/pub/epel/7/x86_64/'
$gempackages      = ['sensu-plugin']
$sensu_package    = ['sensu', 'rubygems', 'uchiwa']
$use_sensu_repo   = true
}
