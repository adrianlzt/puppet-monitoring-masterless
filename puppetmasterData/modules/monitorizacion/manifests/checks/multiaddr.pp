#
# Multiaddr check should be defined:
# Name: multiaddr
# Puppet type: monitorizacion::checks::multiaddr
# Example: {"multiaddr":"IP1,IP2,IPN","args":"-w 800.0,20% -c 999.0,60% -p 5"}
#

define monitorizacion::checks::multiaddr (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

 # Set default values
  if empty($params) {
    fail("You must define at least multiaddr and args option")
  }

  else {
    $params_parsed = parsejson($params)
    $multiaddr = $params_parsed["multiaddr"]
    $args = $params_parsed["args"]
  } 

  if empty($args) and empty ($multiaddr) {
    fail("You must define at least multiaddr and args option")
  }else {
    $final_args = "-H $multiaddr $args"
  }

 # Set params
  $check_name = "check_multiaddr"
  $package_name = "dsmctools-extendedlinux-multiaddress"
  $exec = "${check_name}.pl /usr/lib64/nagios/plugins/check_ping $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}


