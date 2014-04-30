#
# TCP check should be defined:
#   Name: tcp
#   Puppet type: monitorizacion::checks::tcp
#   Example: {"host":"google.com","port":"452","args":"-4"}
#
define monitorizacion::checks::tcp (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("TCP check must have host and port defined")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $host = $params_parsed["host"]
  $port = $params_parsed["port"]
  $final_args = $params_parsed["args"]

  if !$host {
    fail("Host must be defined")
  }
  if !$port {
    fail("Port must be defined")
  }

  # Set params
  $check_name = "check_tcp_${name}"
  $package_name = "nagios-plugins-tcp"
  $exec = "check_tcp -t 5 -H $host -p $port $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
