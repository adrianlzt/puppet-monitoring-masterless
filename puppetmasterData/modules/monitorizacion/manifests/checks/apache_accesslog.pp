#
# Apache access log check should be defined:
#   Name: apache_accesslog
#   Puppet type: monitorizacion::checks::apache_accesslog
#   Example: {"access_log":"/var/log/httpd/access_log","analyze_time":"10","args":"-w 10 -c 20"}
#
# Check will analyze last "analyze_time" minutes in the log file.
# Warning/Critical if percentage of bad codes are higher than warning/critical threshold.
# Good codes are 20X and 30X.
# Warning threshold is 10% by default inside the check. Critical 20%
#
# Log file is set by default to /var/log/httpd/access_log in this manifest
# Analyze time is set by default to 10 min in this manifest
#
define monitorizacion::checks::apache_accesslog (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set params to empty array if params is empty
  if empty($params) {
    $_params = '{}'
  } else {
    $_params = $params
  }

  # Parse JSON data
  $params_parsed = parsejson($_params)
  $final_args = $params_parsed["args"]

  if !$params_parsed["access_log"] {
    $access_log = "/var/log/httpd/access_log"
  } else {
    $access_log = $params_parsed["access_log"]
  }

  if !$params_parsed["analyze_time"] {
    $analyze_time = "10"
  } else {
    $analyze_time = $params_parsed["analyze_time"]
  }

  # Access log file wihtout slashes to define check_name resource
  $access_log_name = regsubst($access_log, '/', '_', 'G')

  # Set params
  $check_name = "check_apache_access_log${access_log_name}"
  $package_name = "dsmctools-apache-accesslog"
  $exec = "check_access_log.pl -l $access_log -m $analyze_time $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
