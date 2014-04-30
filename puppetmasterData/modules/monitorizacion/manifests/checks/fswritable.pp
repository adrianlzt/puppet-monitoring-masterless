#
#   fs_writable should be defined:
#   Name: fs_writable
#   Puppet type: monitorizacion::checks::fswritable
#   Example: {"partition":"/usr"}
#
define monitorizacion::checks::fswritable ( 
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    fail("Error, you must define partition") 
  }
  else{
    $params_parsed = parsejson($params)
    $partition = $params_parsed["partition"]
  }
  if empty($partition){
    fail("Error, you must define partition")
  }else{
    $final_args = "$partition"
  }
  $a2 = regsubst($final_args, '/', '_', 'G') #Cambia todas las / por _ 
  # Set params
  $check_name = "check_fs_writable${a2}" 
  $package_name = "dsmctools-extendedlinux-fswritable" 
  $exec = "check_fs_writable.pl $final_args" 

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
