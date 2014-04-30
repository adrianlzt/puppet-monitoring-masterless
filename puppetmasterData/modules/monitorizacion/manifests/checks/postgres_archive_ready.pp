#
#   check_postgres_archive ready should be defined:
#   Name: postgres_archive_ready
#   Puppet type: monitorizacion::checks::postgres_archive_ready
#   Example: {"mode":"check_postgres_disk_space","hostname":"localhost","dbuser":"nrpe","dbname":"nrpe","dbpass":"nrpe","args":"--warning=80 --critical=70"}

define monitorizacion::checks::postgres_archive_ready (
  $params = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define the args at least mode option")
  }
  else {
    $params_parsed = parsejson($params)
    $hostname = $params_parsed["hostname"]
    $dbuser = $params_parsed["dbuser"]
    $dbpass = $params_parsed["dbpass"]
    $dbname = $params_parsed["dbname"]
    $mode = $params_parsed["mode"]
    $args = $params_parsed["args"]
  } 
  

  if empty($mode) {
    fail("You must define at least the mode option")
  }

  if $hostname {
     $_hostname = "-H $hostname"
  }else{
     $_hostname = ""
  }
  
  if $dbuser {
     $_dbuser = "--dbuser=$dbuser"
  }else{
     $_dbuser = ""
  }

  if $dbpass {
     $_dbpass = "--dbpass=$dbpass"
  }else{
     $_dbpass = ""
  }
 
  if $dbname {
     $_dbname = "--dbname=$dbname"
  }else{
     $_dbname = ""
  }

  if $args {
     $_args = "$args"
  }else{
     $_args = ""
  }

  $final_args = "$_hostname $_dbuser $_dbpass $_dbname $_args"

  # Set params
  $check_name = "check_postgres_archive_ready_${mode}"
  $package_name = "dsmctools-posgresql"
  $exec = "${mode}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
  }

}
