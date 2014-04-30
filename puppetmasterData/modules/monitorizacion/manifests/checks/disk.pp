#
# Disk check should be defined:
#   Name: disk
#   Puppet type: monitorizacion::checks::disk
#   Example: {"disk":"/dev/sda","args":"-w 20% -c 10% -W 20% -K 10%"}
#
# If disk is not defined in the JSON, all disks are checked
#
define monitorizacion::checks::disk (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  
  # Parse JSON data

  # Set params to empty array if params is empty
  if empty($params) {
    $_params = '{}'
  } else {
    $_params = $params
  }

  $params_parsed = parsejson($_params)
  $disk = $params_parsed["disk"]
  $args = $params_parsed["args"]

  # Quitamos las barras del nombre del disco para generar el nombre del fichero
  # Cambiamos la primera barra "/" por "_root_" para el caso del disco raiz
  $disk_temp = regsubst($disk, '/', '_root_')
  $disk_name = regsubst($disk_temp, '/', '_', 'G')

  # Set default values
  if empty($args) {
    $final_args = '-w 20% -c 10% -W 20% -K 10%'
  } else {
    $final_args = $args
  }

  $check_name = "check_disk$disk_name"
  $package_name = "nagios-plugins-disk"
  $exec = "check_disk $final_args $disk"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    vip_name => $vip_name,
    exec => $exec,
  }
}
