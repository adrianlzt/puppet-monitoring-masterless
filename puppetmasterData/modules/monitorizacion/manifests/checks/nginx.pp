#
#   nginx should be defined:
#   Name: nginx
#   Puppet type: monitorizacion::checks::nginx
#   Example: {"hostname":"localhost","port":"80","path":"/var/run","args":"-n nginx.pid"}

define monitorizacion::checks::nginx (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) and empty($port) and empty($path){
    fail("You must define at least the hostname, port and path")
  }
  else {
    $params_parsed = parsejson($params)
    $hostname = $params_parsed["hostname"]
    $port = $params_parsed["port"]
    $path = $params_parsed["path"]
    $args = $params_parsed["args"]
  } 
  
  if empty($hostname) and empty($port) and empty($path){
    fail("You must define at least the hostname, port and path")
  }

  if $args {
     $final_args = "-H $hostname -P $port -p $path $args"
  }else{
     $final_args = "-H $hostname -P $port -p $path"
  }

  # Set params
  $check_name = "check_nginx_${name}"
  $package_name = "dsmctools-nginx"
  $exec = "check_nginx.sh $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
