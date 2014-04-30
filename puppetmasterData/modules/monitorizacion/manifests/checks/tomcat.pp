#
#   tomcat should be defined:
#   Name: tomcat
#   Puppet type: monitorizacion::checks::tomcat
#   Example: {"args":"-H localhost -p 8080 -w 10%,50 -c 5%,10 -l admin -a admin -n ."}
#

define monitorizacion::checks::tomcat (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    fail("You must define at least some params")
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_tomcat"
  $package_name = "dsmctools-tomcat"
  $exec = "${check_name}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
