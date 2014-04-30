class monitorizacion::puppetmaster
{
  package { 'puppetmaster':
    name => $::osfamily ? {
      'Debian' => 'puppetmaster',
      'RedHat' => 'puppet-server',
      default => fail("Module '${module_name}' is not currently supported on ${::operatingsystem}")
    },
    ensure => present,
  }

  package { "ruby-pg":
    ensure => present,
  }

  package { "rubygem-hiera-postgres-backend":
    ensure => present,
    require => [Package['puppetmaster'],Package['ruby-pg']],
    notify => Service['puppetmaster'],
  }

  # Defined types en hiera como ENC
  # http://blog.yo61.com/assigning-resources-to-nodes-with-hiera-in-puppet/
  file { '/usr/lib/ruby/site_ruby/1.8/puppet/parser/functions/hiera_resources.rb':
    source => 'puppet:///modules/monitorizacion/hiera_resources.rb',
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['puppetmaster'],
    notify => Service['puppetmaster'],
  }

  # We will need to restart the puppet master service if certain config
  # files are changed, so here we make sure it's in the catalog.
  if ! defined(Service['puppetmaster']) {
    service { 'puppetmaster':
      ensure => running,
    }
  }

}
