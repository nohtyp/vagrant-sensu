class postgresql::params {

$postgresql_packages        = ['postgresql-server', 'postgresql-devel']
$postgresql_service         = 'postgresql'
$postgresql_ensure          = 'running'
$postgresql_hasstatus       = true
$postgresql_hasrestart      = true
$postgresql_path            = ['/bin']
$postgresql_init_user       = 'postgres'
$postgresql_user_ensure     = 'present'
$postgresql_package_ensure  = 'present'
$postgresql_user            = 'redmine'
$postgresql_user_pw         = 'redmine'
}
