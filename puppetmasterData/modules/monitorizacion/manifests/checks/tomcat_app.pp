#
#   tomcat_app check should be defined:
#   Name: tomcat_app
#   Puppet type: monitorizacion::checks::tomcat_app
#   Example: {"args":"-u user -p password -h host -P port -a application"}
#

define monitorizacion::checks::tomcat_app (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  if empty($params) {
    fail("You must define at least the example params")
  }

  # Parse JSON data

  $params_parsed = parsejson($params)
  $final_args = $params_parsed["args"]

  # Set params
  $check_name = "check_TomcatApplication"
  $package_name = "dsmctools-tomcat-nagios"
  $exec = "${check_name}.sh $final_args"

   monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
 
}
