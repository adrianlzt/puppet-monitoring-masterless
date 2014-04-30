#
# Apache check should be defined:
#   Name: apache
#   Puppet type: monitorizacion::checks::apache
#   Example: {"host":"localhost","measurement":"active_threads","args":"-w 4 -c 8"}
#
# If host is not defined will be set as localhost
#
#
# Host must have enabled mod_status
# http://httpd.apache.org/docs/2.2/mod/mod_status.html
#
# /etc/httpd/conf.d/status.conf:
# <Location /server-status>
# SetHandler server-status
# 
# Order Deny,Allow
# Deny from all
# Allow from 127.0.0.1
# </Location>
# ExtendedStatus On # Can slow down server
#
define monitorizacion::checks::apache (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("Apache check must have, at least, measurement defined")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $measurement = $params_parsed["measurement"]
  $final_args = $params_parsed["args"]

  # Host is set as localhost by default
  if !$params_parsed["host"] {
    $apache_host = "localhost"
  } else {
    $apache_host = $params_parsed["host"]
  }
  if !$measurement {
    fail("measurement must be defined")
  }

  # Set params
  $check_name = "check_apache_${measurement}_${apache_host}"
  $package_name = "dsmctools-apache"
  $exec = "check_apache.pl -H $apache_host -m $measurement $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
