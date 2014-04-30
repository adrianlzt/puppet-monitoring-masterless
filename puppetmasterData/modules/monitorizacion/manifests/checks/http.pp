#
# HTTP check should be defined:
#   Name: http
#   Puppet type: monitorizacion::checks::http
#   Example: {"host":"google.com","port":"452","args":"-4"}
#
define monitorizacion::checks::http (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("HTTP check must have at least host or IP defined")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $host = $params_parsed["host"]
  $port = $params_parsed["port"]
  $final_args = $params_parsed["args"]

  if is_ip_address($host) {
    $checkargs = "-I $host"
  } elsif is_domain_name($host) {
    $checkargs = "-H $host"
  } else {
    fail("Host could not be empty, and must be an ip or a hostname")
  }

  # Set default values
  if !$port {
    $target_port = "80"
  }else{
    $target_port = $port
  }

  # Set params
  $check_name = "check_http_${name}"
  $package_name = "nagios-plugins-http"
  $exec = "check_http -t 5 $checkargs -p $target_port $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
 
}
