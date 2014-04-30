#
#   ssh should be defined:
#   Name: ssh
#   Puppet type: monitorizacion::checks::ssh
#   Example: {"args":"-t 10 localhost"}
#
define monitorizacion::checks::ssh (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-t 10 localhost'
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_ssh"
  $package_name = "nagios-plugins-ssh"
  $exec = "${check_name} $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
