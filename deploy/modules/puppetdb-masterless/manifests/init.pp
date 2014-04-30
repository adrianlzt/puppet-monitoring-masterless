class puppetdb-masterless {

  package { 'puppetdb-terminus':
    ensure => latest,
  }
  
  $puppet_server = 'puppet'
  file { '/etc/puppet/puppetdb.conf':
    content => template("${module_name}/puppetdb.conf.erb"),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  file { '/etc/puppet/puppet.conf':
    content => template("${module_name}/puppet.conf.erb"),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  file { '/etc/puppet/routes.yaml':
    content => template("${module_name}/routes.yaml.erb"),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  file { '/etc/puppet/manifests/site.pp':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/site.pp',
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['puppetmaster'],
    before => Service['puppetmaster'],
  }

  file { '/etc/puppet/manifests/nodes':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/nodes',
    force => true,
    require => Package['puppetmaster'],
    before => Service['puppetmaster'],
  }

  file { '/etc/puppet/modules':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/modules',
    force => true,
    require => Package['puppetmaster'],
    before => Service['puppetmaster'],
  }
}
