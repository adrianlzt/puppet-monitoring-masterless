#
#   gearman should be defined:
#   Name: gearman
#   Puppet type: monitorizacion::checks::gearman
#   Example: {"hostname":"localhost","args":"-t 10"} 
#
define monitorizacion::checks::gearman (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    $final_args =  '-H localhost -t 10'
  }
  else {
  $params_parsed = parsejson($params)
  $hostname = $params_parsed["hostname"]
  $args = $params_parsed["args"]
  
  $final_args = "-H $hostname $args"
  } 

  # Set params
  $check_name = "check_gearman"
  $package_name = "mod_gearman"
  $exec = "${check_name} $final_args"
  
  file { "/usr/lib64/nagios/plugins/check_gearman":
    ensure => link,
    target => "/usr/bin/check_gearman",
  }
 
  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
