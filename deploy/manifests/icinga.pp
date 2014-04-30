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
class { 'repoforge': }

yumrepo { 'labs-consol-stable':
    descr => "Consol.de labs repository",
    baseurl => "http://labs.consol.de/repo/stable/rhel6/\$basearch",
    gpgcheck => 0,
    gpgkey => "http://labs.consol.de/repo/stable/RPM-GPG-KEY",
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
  require => Class['puppetlabs_yum'],
}

# Needed to read custom facts
# Install json gem for ruby-1.8
package { 'rubygem-json':
  ensure => 'present',
  require => Yumrepo['local'],
}
->
class { 'facter_propios': 
  facts => '{ "env": "pre" }',
}
