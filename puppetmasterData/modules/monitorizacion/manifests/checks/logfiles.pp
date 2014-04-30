#
# Logfiles check should be defined:
#   Name: logfiles
#   Puppet type: monitorizacion::checks::logfiles
#   Example: {"tag":"TXerror","logfile":"/var/log/file.log","args":"--criticalpattern='.*TX-error.*' --warningpattern='.*TX-warn'"}
#
define monitorizacion::checks::logfiles (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("Logfiles check must have defined tag and logfile at least")
  }

  # Parse JSON data
  $params_parsed = parsejson($params)
  $tag = $params_parsed["tag"]
  $logfile = $params_parsed["logfile"]
  $final_args = $params_parsed["args"]

  if !$tag {
    fail("Tag must be defined")
  }
  if !$logfile {
    fail("Logfile must be defined")
  }

  # Set params
  $logfile_without_slashes = regsubst($logfile, '/', '_','G')
  $check_name = "check_logfiles_${tag}${logfile_without_slashes}"
  $package_name = "dsmctools-extendedlinux-logfiles"
  $exec = "check_logfiles.pl --tag=$tag --logfile=$logfile $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
