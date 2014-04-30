class puppetclient (
  $server = 'puppet'
)
{

  package { "puppet":
    ensure => present, 
  }

  file { '/etc/puppet/puppet.conf':
    content => template("${module_name}/puppet.conf.erb"),
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['puppet'],
  }

}
