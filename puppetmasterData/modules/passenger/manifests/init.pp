class passenger (
  $ruby_path,
  $gem_path,
  $passenger_root,
  $mod_passenger_location,
)
{

  package {'rubygem1.9.3-passenger':
    ensure => installed,
    notify => Class['apache::service'],
  }

  package {'libcurl-devel':
    ensure => installed,
  }

  file {'/etc/httpd/conf.d/passenger.conf':
    content => template('passenger/passenger.conf.erb'),
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['rubygem1.9.3-passenger'],
    notify => Class['apache::service'],
  }
}
