# == Class: icinga
#
# Full description of class icinga here.
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
#  class { icinga:
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
class icinga {

  package { 'icinga':
    ensure => 'present',
  }

  package { 'httpd':
    ensure => 'present',
  }

  service { 'icinga':
    ensure     => running,
    enable     => true,
    require => Package['icinga'],
  }

  package { 'icinga-gui':
    ensure => 'present',
    require => [Package['icinga'],Package['httpd']],
  }

  service { 'httpd':
    ensure     => running,
    enable     => true,
    require => Package['icinga-gui'],
  }

  $plugins = ['nagios-plugins-disk.x86_64','nagios-plugins-http.x86_64','nagios-plugins-load.x86_64','nagios-plugins-nrpe.x86_64','nagios-plugins-ping.x86_64','nagios-plugins-procs.x86_64','nagios-plugins-ssh.x86_64','nagios-plugins-swap.x86_64','nagios-plugins-users.x86_64','nagios-plugins-dummy.x86_64']
  package { $plugins :
    ensure => present,
    require => Package['icinga']
  }


}
