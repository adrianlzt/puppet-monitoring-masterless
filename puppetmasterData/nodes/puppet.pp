node 'puppet' inherits default {
  class { 'puppetdb':
    database_listen_address => "*",
  }
  include puppetdb::master::config
  include monitorizacion::puppetmaster

  class { 'monitorizacion::webui' : # User interface to manage automatic monitoring
    #alias => "ui",
    virtualhost => hiera('ui_virtualhost'),
    document_root => hiera('ui_docroot'),
    require => Class['puppetdb'], # If this module is installed first, error with duplicated postgresql package in class puppetdb
  }

}
