class redmine::params {

$redmine_packages      = ['wget', 'gcc', 'kernel-devel', 'ruby-devel', 'postgresql-devel', 'ImageMagick-devel']
$redmine_user          = 'redmine'
$redmine_group         = 'redmine'
$redmine_gems          = ['bundler'] 
$redmine_version       = '3.3.0'
$redmine_url           = 'http://www.redmine.org/releases/'
$redmine_wget_pkg      = "redmine-${redmine_version}.tar.gz"
$redmine_adapter       = 'postgresql'
$redmine_dbname        = 'redmine'
$redmine_host          = 'localhost'
$redmine_username      = 'redmine' 
$redmine_password      = 'redmine'
$redmine_directory     = "redmine-${redmine_version}"
$redmine_dir_path      = "/opt"
$redmine_encoding      = 'utf8'
}
