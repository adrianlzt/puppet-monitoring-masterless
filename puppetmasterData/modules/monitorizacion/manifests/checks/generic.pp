#
# A generic check should be defined:
#   Name: generic
#   Puppet type: monitorizacion::checks::generic
#   Example: {"check_name":"check_something","args":"-a 1 -b 2 -c 3"}
#
# check_name should be an executable located in /usr/lib64/nagios/plugins/
#
define monitorizacion::checks::generic (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("Generic service should define command and args")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $_check_name = $params_parsed["check_name"]
  $final_args = $params_parsed["args"]

  # Set params
  $check_name = "${_check_name}-${name}"
  $package_name = "nagios-plugins"
  $exec = "$_check_name $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
