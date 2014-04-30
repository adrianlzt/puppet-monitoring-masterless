package { 'screen':
  ensure => present,
}

service {'iptables':
  ensure     => stopped,
  enable     => false,
}

host { 'puppet':
  ip => '192.168.61.2',
}

host { 'icinga':
  ip => '192.168.61.4',
}

class { 'epel': }

class { 'puppetlabs_yum': }
class { 'puppetclient': 
  require => Class['puppetlabs_yum'],
}
class { 'facter_propios': 
  facts => '{"monitoring": "true","project": "bluevia", "env": "dev-vagrant", "interface": "eth1"}',
}
