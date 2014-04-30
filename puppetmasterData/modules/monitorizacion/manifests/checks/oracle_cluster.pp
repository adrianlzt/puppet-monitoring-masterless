#
#   oracle_cluster should be defined:
#   Name: oracle_cluster
#   Puppet type: monitorizacion::checks::oracle_cluster
#   Example: {"action":"resstatus","cluster_home":"/u01/11.2.0/grid","args":"--exclude=ora.bmrs.bmrs_service_preconnect.svc"}

define monitorizacion::checks::oracle_cluster (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least the action and the cluster")
  }
  else {
    $params_parsed = parsejson($params)
    $action = $params_parsed["action"]
    $cluster_home = $params_parsed["cluster_home"]
    $args = $params_parsed["args"]
  } 
  
  if empty($action) or empty($cluster_home) {
    fail("You must define at least the action and the cluster")
  }

  if $args {
     $final_args = "--action $action --crs_home=$cluster_home $args"
  }else{
     $final_args = "--action $action --crs_home=$cluster_home"
  }

  # Set params
  $check_name = "check_oracle_cluster"
  $package_name = "dsmctools-oracle-cluster"
  $exec = "check_crs.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
