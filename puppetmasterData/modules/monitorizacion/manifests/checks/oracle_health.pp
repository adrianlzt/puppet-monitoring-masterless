#
#   oracle_health should be defined:
#   Name: oracle_health
#   Puppet type: monitorizacion::checks::oracle_health
#   Example: {"mode":"switch-interval","args":"--connect rac1"}

define monitorizacion::checks::oracle_health (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least the mode")
  }
  else {
    $params_parsed = parsejson($params)
    $mode = $params_parsed["mode"]
    $args = $params_parsed["args"]
  } 
  
  if empty($mode) {
    fail("You must define at least the mode")
  }

  if $args {
     $final_args = "--mode $mode $args"
  }else{
     $final_args = "--mode $mode"
  }

  # Set params
  $check_name = "check_oracle_health${name}"
  $package_name = "dsmctools-oracle-health"
  $exec = "check_oracle_health.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
