# == Class: puppetmaster
#
# Full description of class puppetmaster here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { puppetmaster:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class puppetmaster {

  package { 'puppetmaster':
    name => $::osfamily ? {
      'Debian' => 'puppetmaster',
      'RedHat' => 'puppet-server',
      default => fail("Module '${module_name}' is not currently supported on ${::operatingsystem}")
    },
    ensure => present,
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

  file { '/etc/init.d/puppetmaster':
   source => "puppet:///modules/${module_name}/puppetmaster",
   owner => root,
   group => root,
   mode => 0755,
   require => Package['puppetmaster'],
   before => Service['puppetmaster'],
 }

  service { 'puppetmaster': 
    ensure => running,
    enable => true,
  }
}
