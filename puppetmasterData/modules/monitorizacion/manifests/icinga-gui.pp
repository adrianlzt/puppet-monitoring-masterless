class monitorizacion::icinga-gui {
  ensure_resource('class', 'apache', { })
  ensure_resource('class', 'apache::dev', { })

  package { 'icinga-gui':
    ensure => 'present',
    require => [Package['icinga'],Class['apache']],
  }

  file { "/etc/httpd/conf.d/icinga.conf":
    source => 'puppet:///modules/monitorizacion/icinga.conf',
    owner => 'root',
    group => 'root',
    mode => '0644',
    notify => Class['apache::service'],
    require => [Package['icinga-gui'],Class['apache']],
  }

   file { "$icinga_root_dir/cgi.cfg":
     source => "puppet:///modules/${module_name}/cgi.cfg",
     owner => $user,
     group => $group,
     mode => '0640',
     require => Package['icinga'],
     before => Anchor['conf-after-run'],
     notify => Service['icinga'],
   }
}
