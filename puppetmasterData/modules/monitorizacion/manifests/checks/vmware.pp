#
#   vmware should be defined:
#   Name: vmware
#   Puppet type: monitorizacion::checks::vmware
#   Example: {"hostname":"localhost","username":"name","password":"pass","file":"/usr/lib64/nagios/plugins/check_vmware_auth","mode":"cpu","args":"-w 70 -c 80 -s usage"}

define monitorizacion::checks::vmware (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params
	

  # Set default values
  if empty($params) {
    fail("You must define at least the hostname, username, password, and mode")
  }
  else {
    $params_parsed = parsejson($params)
    $hostname = $params_parsed["hostname"]
    $username = $params_parsed["username"]
    $password = $params_parsed["password"]
    $file = $params_parsed["file"]
    $mode = $params_parsed["mode"]
    $args = $params_parsed["args"]
  } 
  
  if empty($hostname) and empty($mode){
    fail("You must define at least the hostname and the mode")
  }

  if !empty($username) and !empty($password){
    $temp= "--username $username --password $password"
  }else{
    if !empty($file){
      $temp="-f $file"
    }else{
      fail("You must define at least the user and password or the file with this arguments")
    }
  }

  if $args {
     $final_args = "-H $hostname $temp -l $mode $args"
  }else{
     $final_args = "-H $hostname $temp -l $mode"
  }

  # Set params
  $check_name = "check_vmware_${name}"
  $package_name = "dsmctools-vmware"
  $exec = "check_vmware_api.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
