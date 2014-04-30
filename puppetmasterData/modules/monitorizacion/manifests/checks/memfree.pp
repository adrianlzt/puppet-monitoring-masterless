#
#   mem check free should be defined:
#   Name: mem_free
#   Puppet type: monitorizacion::checks::memfree
#   Example:  -w 15 -c 5
#
define monitorizacion::checks::memfree (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-w 15 -c 5'
  }
  else {
    $final_args = $params
  } 

  # Set params
  $check_name = "check_mem_free"
  $package_name = "dsmctools-basiclinux-memory"
  $exec = "check_mem.pl -f $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
