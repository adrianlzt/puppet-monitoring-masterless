#
#   diskio check should be defined:
#   Name: diskio
#   Puppet type: monitorizacion::checks::diskio
#   Example: {"device":"/dev/sda1","args":"--warning=102400 --critical=122880"}



define monitorizacion::checks::diskio (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  
 # Parse JSON data
  if empty($params){
    fail ("You must define at least a device and warning and critical args")
  }else{
    $params_parsed = parsejson($params)
    $device = $params_parsed["device"]
    $args = $params_parsed["args"] 
  }
  if empty($device) or empty($args){
    fail ("You must define at least a device and warning and critical args")
  }else{ 
    $final_args = "--device=$device $args"
  }
  
      
  # Set params
  $check_name = "check_diskio_${name}"
  $package_name = "dsmctools-extendedlinux-diskio"
  $exec = "check_diskio.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

