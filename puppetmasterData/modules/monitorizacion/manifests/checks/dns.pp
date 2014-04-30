#
# DNS check should be defined:
#   Name: dns
#   Puppet type: monitorizacion::checks::dns
#   Example: {"host":"machine.subdom.com","args":"-s 8.8.8.8"}
#
define monitorizacion::checks::dns (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("DNS check must have host defined")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $host = $params_parsed["host"]
  $final_args = $params_parsed["args"]

  if !$host {
    fail("Host must be defined")
  }

  # Set params
  $check_name = "check_dns_${host}"
  $package_name = "nagios-plugins-dns"
  $exec = "check_dns -H $host $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
