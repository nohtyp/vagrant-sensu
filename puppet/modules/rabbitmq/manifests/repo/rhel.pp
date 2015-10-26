# Class: rabbitmq::repo::rhel
# Imports the gpg key if it doesn't already exist.
class rabbitmq::repo::rhel {

if $rabbitmq::external_repo {
 exec {"yum -y install ${rabbitmq_url}/v${rabbit_version}/rabbitmq-server-${rabbit_version}-${rabbit_minor}.noarch.rpm":
   path   => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
   unless => 'rpm -qa rabbitmq-server 2>/dev/null', 
    }
 exec { "rpm --import ${package_gpg_key}":
   path   => ['/bin','/usr/bin','/sbin','/usr/sbin'],
   unless => 'rpm -q gpg-pubkey-056e8e56-468e43f2 2>/dev/null',
   }
  }
}
