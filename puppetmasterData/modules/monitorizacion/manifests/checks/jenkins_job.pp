#
#   jenkins_job should be defined:
#   Name: jenkins_job
#   Puppet type: monitorizacion::checks::jenkins_job
#   Example: {"url":"http://ci-iptv-01/jenkins/","job_name":"csharp-example","concurrent_fails":"5","build_duration":"133","warning":"130","critical":"135","args":""}

define monitorizacion::checks::jenkins_job (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define all the arguments except args")
  }
  else {
    $params_parsed = parsejson($params)
    $url = $params_parsed["url"]
    $job_name = $params_parsed["job_name"]
    $concurrent_fails = $params_parsed["concurrent_fails"]
    $build_duration = $params_parsed["build_duration"]
    $warning = $params_parsed["warning"]
    $critical = $params_parsed["critical"]
    $args = $params_parsed["args"]
  } 
  
  if empty($url) or empty($job_name) or empty($concurrent_fails) or empty($build_duration) or empty($warning) or empty($critical) {
    fail("You must define all the arguments excepet args")
  }else{
    $_final_args = "$url $job_name $concurrent_fails $build_duration $warning $critical"
  }

  if $args {
     $final_args = "$_final_args $args"
  }else{
     $final_args = "$_final_args"
  }

  # Set params
  $check_name = "check_jenkins_extended_${name}"
  $package_name = "dsmctools-jenkins-job"
  $exec = "check_jenkins_job_extended.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
