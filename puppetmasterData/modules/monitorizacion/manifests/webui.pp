#
# Could deploy as suburi or virtual host
#

class monitorizacion::webui
(
  $document_root = "/var/www/html/puppet-monitoring-ui",
  $port = 80,
  $virtualhost = undef,
  $alias = undef,
)
{
  
  if !$alias and !$virtualhost {
    fail("You should define how to deploy setting $virtualhost or $alias")
  } elsif $alias and $virtualhost {
    fail("You should define how to deploy setting $virtualhost or $alias, not both")
  }
 
  include monitorizacion::params
  require rvm

  ensure_resource('class', 'apache', { })
  ensure_resource('class', 'apache::dev', { })
 
  package { 'ruby-devel':
    ensure => 'present',
  }

  # Gems needed by app (extracted from Gemfile.lock)
  # RPMs install files for ruby-1.9.3
  package { ['rubygem1.9.3-actionmailer','rubygem1.9.3-actionpack','rubygem1.9.3-activemodel','rubygem1.9.3-activerecord','rubygem1.9.3-activerecord-deprecated_finders','rubygem1.9.3-activesupport','rubygem1.9.3-arel','rubygem1.9.3-atomic','rubygem1.9.3-builder','rubygem1.9.3-bundler','rubygem1.9.3-coffee-rails','rubygem1.9.3-coffee-script','rubygem1.9.3-coffee-script-source','rubygem1.9.3-devise','rubygem1.9.3-erubis','rubygem1.9.3-execjs','rubygem1.9.3-hike','rubygem1.9.3-i18n','rubygem1.9.3-jbuilder','rubygem1.9.3-jquery-rails','rubygem1.9.3-json','rubygem1.9.3-libv8','rubygem1.9.3-mail','rubygem1.9.3-mime-types','rubygem1.9.3-minitest','rubygem1.9.3-multi_json','rubygem1.9.3-paper_trail','rubygem1.9.3-pg','rubygem1.9.3-polyglot','rubygem1.9.3-rack','rubygem1.9.3-rack-test','rubygem1.9.3-rails','rubygem1.9.3-railties','rubygem1.9.3-rake','rubygem1.9.3-rdoc','rubygem1.9.3-ref','rubygem1.9.3-sass','rubygem1.9.3-sass-rails','rubygem1.9.3-sdoc','rubygem1.9.3-sprockets','rubygem1.9.3-sprockets-rails','rubygem1.9.3-sqlite3','rubygem1.9.3-therubyracer','rubygem1.9.3-thor','rubygem1.9.3-thread_safe','rubygem1.9.3-tilt','rubygem1.9.3-treetop','rubygem1.9.3-turbolinks','rubygem1.9.3-tzinfo','rubygem1.9.3-uglifier','rubygem1.9.3-rest-client','rubygem1.9.3-excon','rubygem1.9.3-formatador','rubygem1.9.3-net-ssh','rubygem1.9.3-net-scp','rubygem1.9.3-fog-core','rubygem1.9.3-fog-json','rubygem1.9.3-fog-brightbox','rubygem1.9.3-mini_portile','rubygem1.9.3-nokogiri','rubygem1.9.3-fog']:
    ensure => 'present',
    require => Package['ruby-devel'],
  }
  
  # Problems with puppetdb class if defined postgresql here
  #ensure_resource('package', 'postgresql', {'ensure' => 'present' })

  class {'passenger':
    ruby_path => '/usr/local/rvm/wrappers/ruby-1.9.3-p545',
    gem_path => '/usr/local/rvm/gems/ruby-1.9.3-p545/bin:/usr/local/rvm/gems/ruby-1.9.3-p545@global/bin',
    passenger_root => '/usr/local/rvm/gems/ruby-1.9.3-p545/gems/passenger-4.0.37',
    mod_passenger_location => '/usr/local/rvm/gems/ruby-1.9.3-p545/gems/passenger-4.0.37/buildout/apache2/mod_passenger.so',
    require => [Class['apache'],Class['apache::dev']],
  }

  if $alias { # Sub URI
    file {'/etc/httpd/conf.d/monitorizacionui.conf':
      content => template("${module_name}/monitorizacionui.conf.suburi.erb"),
      owner => 'root',
      group => 'root',
      mode => '0644',
      require => Class['passenger'],
      notify => Class['apache::service'],
    }
  
    file { "/var/www/html/$alias":
      ensure => link,
      target => "$document_root/public",
      before => File['/etc/httpd/conf.d/monitorizacionui.conf'],
    }
  } else { # Virtual Host
    file {'/etc/httpd/conf.d/monitorizacionui.conf':
      content => template("${module_name}/monitorizacionui.conf.vhost.erb"),
      owner => 'root',
      group => 'root',
      mode => '0644',
      require => Class['passenger'],
      notify => Class['apache::service'],
    }
  }
}

