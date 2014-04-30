class puppetdb-masterless (
  $server = 'puppet'
)
{

  package { 'puppetdb-terminus':
    ensure => latest,
  }
  
  file { '/etc/puppet/puppetdb.conf':
    content => template("${module_name}/puppetdb.conf.erb"),
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
  
  file { '/etc/puppet/manifests' :
    ensure => 'directory',
    owner => 'root',
    group => 'root',
  }

  file { '/etc/puppet/manifests/site.pp':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/site.pp',
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => File['/etc/puppet/manifests'],
  }

  file { '/etc/puppet/manifests/nodes':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/nodes',
    force => true,
    require => File['/etc/puppet/manifests'],
  }

  file { '/etc/puppet/modules':
    ensure => 'link',
    target => '/vagrant/puppetmasterData/modules',
    force => true,
  }
}
