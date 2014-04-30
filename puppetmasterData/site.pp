Stage['pre'] -> Stage['main']
stage { 'pre': }

if $::monitoring {
  if !$::project {
    fail("Node must define a project name in custom facts")
  }
  if !$::env {
    fail("Node must define a environment (env) in custom facts")
  }

  # Configure repos before try to install any package
  class { 'monitorizacion::repos': 
    stage => 'pre',
    tag => "pepe",
  }
  
  class { 'monitorizacion::basic':
    allowed_hosts => hiera('allowed_hosts'),
    icinga_host => hiera('icinga_host'),
  }
  hiera_resources('vip_nodes')
  hiera_resources('services')
} 

# We use an import declaration to import all node definitions
import 'nodes/*.pp'
