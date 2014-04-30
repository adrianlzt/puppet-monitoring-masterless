#
#   mysql_counters check should be defined:
#   Name: mysql_counters
#   Puppet type: monitorizacion::checks::mysql_counters
#   Example: {"hostname":"host","port":"3306","username":"icinga","password":"icingapass"}


define monitorizacion::checks::mysql_counters (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  $params_parsed = parsejson($params)
  $hostname = $params_parsed["hostname"]
  $port = $params_parsed["port"]
  $username = $params_parsed["username"]
  $password = $params_parsed["password"]

  if empty($hostname) or empty($username) or empty($password) or empty($port) {
    fail("You must define a host, port, user and password")
  }else {
    $final_args = "-H $hostname -P $port -u $username -p $password" 
  }
  
  # Set params
  $check_name = "check_mysql_counters_${name}"
  $package_name = "dsmctools-mysql-counters"
  $exec = "check_mysql_counters.php $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}
