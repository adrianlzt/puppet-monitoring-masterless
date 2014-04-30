define monitorizacion::viphost (
  $address,
)
{
  include monitorizacion::params

  $host_name = "${::project}_${name}"
  $alias = $name
  $hostgroups = "$::project,${::project}-vip"

  $tagname = "icinga-${::env}"

  # VIP should belong to which hostgroups?
  # if empty($::hostgroup) {
  #   $hostgroups = $::project
  # } else {
  #   # Prefix project name to hostgroups. fronted -> project-frontend
  #   $hg_array = split($::hostgroup,",")
  #   $hg_array_prefix = prefix($hg_array,"$::project-")
  #   $hg_string_prefix = join($hg_array_prefix,",")

  #   $hostgroups = join([$::project,$hg_string_prefix],",")
  # }

  # Define general hostgroup for project
  @@monitorizacion::icinga::hostgroup { "${monitorizacion::params::resourcehost}-${name}-vip": 
    nagiosalias => "${::project} group for VIPs",
    servicename => "${::project}-vip",
    tag => $tagname, 
    export => true,
  }

  @@monitorizacion::icinga::host { "${monitorizacion::params::resourcehost}-${name}":
    host_name => $host_name,
    hostgroups => $hostgroups,
    nagiosalias => $alias,
    address => $address,
    project => $::project,
    tag => $tagname,
  }
}
