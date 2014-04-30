package { 'screen':
  ensure => present,
}

service {'iptables':
  ensure     => stopped,
  enable     => false,
}

# Extraido de https://github.com/garethr/puppetmaster-vagrant/blob/master/manifests/server.pp

Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

class {'ruby':
  gems_version => 'latest'
}

yumrepo { 'local':
    descr => "Local repository",
    baseurl => "file:///vagrant/localrepo",
    gpgcheck => 0,
}

yumrepo { 'bintray':
    descr => "BinTray repository",
    baseurl => "http://dl.bintray.com/adrianlzt/rpm",
    gpgcheck => 0,
}

class { 'puppetlabs_yum': }


class { 'puppetclient': 
  require => Class['puppetlabs_yum']
}


# Instalamos hiera via gema antes que el puppetmaster instale hiera via yum
# Mirar el manifest de hiera
class { 'hiera':
  require => Package['puppet'],
  before => Class['puppetmaster'],
}

file { '/etc/puppet/autosign.conf':
  ensure  => present,
  content => '*',
  require => Package['puppet'],
}

class {'puppetmaster':
  require => File['/etc/puppet/autosign.conf'],
}

package { "ruby-pg":
  ensure => present,
}

package { "rubygem-hiera-postgres-backend":
  ensure => present,
  require => [Package['puppetmaster'],Package['ruby-pg']],
  notify => Service['puppetmaster'],
}


# Instalo postgresql listo para usar con puppetdb
class { 'puppetdb::database::postgresql': 
  listen_addresses           => '*',
}


# Creo usuario y bd para el backend postgres de hiera, e importo los datos
# Se importa el fichero monitoring.sql del modulo monitoring_data
$database = 'monitoring'
$importedflag = "/var/lib/pgsql/db_imported.flag"

class {'monitoring_data':
  database => $database,
  importedflag => $importedflag,
}

class { 'facter_propios': 
  facts => '{ "env": "dev-vagrant" }',
}

