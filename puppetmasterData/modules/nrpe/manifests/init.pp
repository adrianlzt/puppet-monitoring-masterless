# == Class: nrpe
#
# Full description of class nrpe here.
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
#  class { nrpe:
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
class nrpe (
  $server_address = false,
  $nrpe_user = 'nrpe',
  $nrpe_group = 'nrpe',
  $allowed_hosts = ['127.0.0.1'],
)
{

  package { 'nrpe':
    ensure   => present,
    name     => 'nrpe',
  }

  file { '/etc/nagios/nrpe.cfg':
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template('nrpe/nrpe.cfg.erb'),
    require => Package['nrpe'],
    notify => Service['nrpe'],
  }

  # Con purge logramos que se borren automaticamente los checks antiguos
  file { '/etc/nrpe.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
    recurse => true,
    purge => true,
    require => Package['nrpe'],
  }


  service { 'nrpe':
    ensure => running,
    enable => true,
    require => File['/etc/nagios/nrpe.cfg'],
  }
}
