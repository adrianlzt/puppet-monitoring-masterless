#
# User check should be defined:
#   Name: users
#   Puppet type: monitorizacion::checks::users
#   Example: {"args":"-w 5 -c 10"}
#
define monitorizacion::checks::users (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args = '-w 5 -c 10'
  } else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  }

  # Set params
  $check_name = "check_users"
  $package_name = "nagios-plugins-users"
  $exec = "$check_name $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
