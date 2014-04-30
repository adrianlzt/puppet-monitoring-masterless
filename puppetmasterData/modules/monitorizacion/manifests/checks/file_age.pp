
#
# File_age check should be defined:
# Name: file_age
# Puppet type: monitorizacion::checks::file_age
# Example: {"args":"-w 240 -c 600 -W 100 -C 200"}
#

define monitorizacion::checks::file_age (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

 # Set default values
  if empty($params) {
    $final_args = "-w 240 -c 600 -W 100 -C 200"
  }

  else {
    $params_parsed = parsejson($params)
    $final_args = $params_parsed["args"]
  }

 # Set params
  $check_name = "check_file_age"
  $package_name = "dsmctools-commonlinux-fileage"
  $exec = "${check_name}.pl $final_args"


  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
