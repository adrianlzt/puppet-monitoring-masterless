package { 'screen':
  ensure => present,
}

service {'iptables':
  ensure     => stopped,
  enable     => false,
}

host { 'puppet':
  ip => '192.168.51.2',
}

host { 'icinga':
  ip => '192.168.51.4',
}

class { 'epel': }

class { 'puppetlabs_yum': }
class { 'puppetclient': 
  server => 'false',
  require => Class['puppetlabs_yum'],
}
class { 'facter_propios': 
  facts => '{"monitoring": "true","project": "bluevia", "env": "dev-vagrant", "interface": "eth1"}',
}
class { 'puppetdb-masterless':
  server => 'puppet',
  require => Class['puppetclient'],
}
