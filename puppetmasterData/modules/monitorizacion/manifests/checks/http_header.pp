#
# HTTP header should be defined:
#   Name: http_header
#   Puppet type: monitorizacion::checks::http_header
#   Example: {"host":"localhost","url":"/","port":"80","regex":"SAMEORIGIN","timeout":"5"}
#
# If host is not defined will be set as localhost
# If port is not defined will be set as 80
# If url is not defined will be set as /
# If timeout is not defined will be set as 5
#
define monitorizacion::checks::http_header (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("Apache check must have, at least, regex defined")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $host = $params_parsed["host"]
  $url = $params_parsed["url"]
  $port = $params_parsed["port"]
  $regex = $params_parsed["regex"]
  $timeout = $params_parsed["timeout"]

  if !$params_parsed["host"] {
    $http_host = "localhost"
  } else {
    $http_host = $params_parsed["host"]
  }

  if !$params_parsed["port"] {
    $http_port = "80"
  } else {
    $http_port = $params_parsed["port"]
  }

  if !$params_parsed["url"] {
    $http_url = "/"
  } else {
    $http_url = $params_parsed["url"]
  }

  if !$params_parsed["timeout"] {
    $http_timeout = "5"
  } else {
    $http_timeout = $params_parsed["timeout"]
  }

  if !$regex {
    fail("regex must be defined")
  }

  $http_url_name = regsubst($http_url, '/', '_', 'G')
  $name_without_blanks = regsubst($name, ' ', '_', 'G')

  # Set params
  $check_name = "check_http_header_${http_host}${http_url_name}-${name_without_blanks}"
  $package_name = "dsmctools-apache-httpheader"
  $exec = "check_http_header.pl -I $http_host -u $http_url -r $regex -t $http_timeout -p $http_port"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
