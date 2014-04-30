#
#   jenkins should be defined:
#   Name: jenkins
#   Puppet type: monitorizacion::checks::jenkins
#   Example: {"url":"localhost","args":"-w 100 -c 200"}

define monitorizacion::checks::jenkins (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least the arguments except args")
  }
  else {
    $params_parsed = parsejson($params)
    $url = $params_parsed["url"]
    $args = $params_parsed["args"]
  } 
  
  if empty($url) {
    fail("You must define at least the url")
  }

  if $args {
     $final_args = "$url $args"
  }else{
     $final_args = "$url"
  }

  # Set params
  $check_name = "check_jenkins"
  $package_name = "dsmctools-jenkins"
  $exec = "${check_name}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
