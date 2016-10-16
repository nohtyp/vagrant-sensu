class redmine::params {

$redmine_packages           = ['wget', 'gcc', 'kernel-devel', 'ruby-devel', 'ImageMagick-devel', 'httpd', 'gcc-c++', 'libcurl-devel', 'httpd-devel','postgresql-server', 'postgresql-devel', 'rubygem-rack', 'zlib-devel', 'apr-devel', 'apr-util-devel']
$redmine_user               = 'redmine'
$redmine_group              = 'redmine'
$apache_user                = 'apache'
$apache_group               = 'apache'
$redmine_gems               = ['bundler', 'passenger'] 
$redmine_version            = '3.3.0'
$redmine_url                = 'http://www.redmine.org/releases'
$redmine_wget_pkg           = "redmine-${redmine_version}.tar.gz"
$redmine_adapter            = 'postgresql'
$redmine_dbname             = 'redmine'
$redmine_host               = 'localhost'
$redmine_username           = 'redmine' 
$redmine_password           = 'redmine'
$redmine_directory          = "redmine-${redmine_version}"
$redmine_dir_path           = "/var/www/html"
$redmine_encoding           = 'utf8'
$webserver_name             = 'test.familyguy.local'
$passenger_conf             = '/etc/httpd/conf.d/passenger.conf'
$http_conf                  = '/etc/httpd/conf/httpd.conf'
$http_ensure                = 'running'
$http_name                  = 'httpd'
$passenger_version          = 'passenger-5.0.30'
$public_directory           = '/public'
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
$openssl_cert               = '/C=US/ST=Maryland/L=Suitland/O=NOAA/OU=GRAVITE/CN=fts02test'
$openssl_keyout             = '/etc/pki/tls/private/fts02test.key'
$openssl_certout            = '/etc/pki/tls/private/fts02test.cert'
$rsa_strength               = '4096'
$rsa_days                   = '3653'
$database_ensure            = 'present'
$database_runas             = 'postgres'
$database_name              = 'redmine'
$database_owner             = 'redmine'
}
