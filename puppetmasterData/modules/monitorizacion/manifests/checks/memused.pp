#
#   mem check used should be defined:
#   Name: mem_used
#   Puppet type: monitorizacion::checks::memused
#   Example: -w 85 -c 95
#
define monitorizacion::checks::memused (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args = '-w 85 -c 95'
  }
  else {
    $final_args = $params
  } 

  # Set params
  $check_name = "check_mem_used"
  $package_name = "dsmctools-basiclinux-memory"
  $exec = "check_mem.pl -u $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
