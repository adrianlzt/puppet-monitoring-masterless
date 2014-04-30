#
#   jenkins_cron should be defined:
#   Name: jenkins_cron
#   Puppet type: monitorizacion::checks::jenkins_cron
#   Example: {"job":"csharp-example","url":"http://ci-iptv-01/jenkins/","warning":"500000","critical":"1000000","args":"-f"}

define monitorizacion::checks::jenkins_cron (
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
    $job = $params_parsed["job"]
    $url = $params_parsed["url"]
    $warning = $params_parsed["warning"]
    $critical = $params_parsed["critical"]
    $args = $params_parsed["args"]
  }


  if empty($job) or empty($url) or empty($warning) or empty($critical) {
    fail("You must define at least the arguments except args")
  }else{
    $_final_args = "-j $job -l $url -w $warning -c $critical"
  }

  if $args {
     $final_args = "$_final_args $args"
  }else{
     $final_args = "$_final_args"
  }

  # Set params
  $check_name = "check_jenkins_cron"
  $package_name = "dsmctools-jenkins-cron"
  $exec = "${check_name}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}

