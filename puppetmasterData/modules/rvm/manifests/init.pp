class rvm {

  # Comes with ruby-1.9.3-p545 installed
  package { 'ruby-rvm':
    ensure => '1.25.19-4',
  }

  file { '/etc/bash.bashrc':
    ensure => file,
  }
  ->
  file_line { 'bash.bashrc-rvm':
    ensure => present,
    line   => 'type rvm >/dev/null 2>/dev/null || echo ${PATH} | __rvm_grep "/usr/local/rvm/bin" > /dev/null || export PATH="${PATH}:/usr/local/rvm/bin"',
    path   => '/etc/bash.bashrc',
    require => Package['ruby-rvm'],
  }

}
