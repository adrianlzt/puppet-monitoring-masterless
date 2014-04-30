class monitorizacion::params {

  $icinga_root_dir = hiera('icinga_root_dir','/etc/icinga')
  $icinga_conf_dir = hiera('icinga_conf_dir',"etc/icinga/conf.d")
  $icinga_log_file = hiera('icinga_log_file',"/var/log/icinga/icinga.log")
  $icinga_object_cache_file = hiera('icinga_object_cache_file',"/var/spool/icinga/objects.cache")
  $icinga_precached_object_file = hiera('icinga_precached_object_file',"/var/spool/icinga/objects.precache")
  $icinga_status_file = hiera('icinga_status_file',"/var/spool/icinga/status.dat")
  $icinga_external_command_buffer_slots = hiera('icinga_external_command_buffer_slots','4096')
  $icinga_temp_file = hiera('icinga_temp_file',"/tmp/icinga.tmp")
  $icinga_temp_path = hiera('icinga_temp_path',"/tmp")
  $icinga_log_archive_path = hiera('icinga_log_archive_path',"/var/log/icinga/archives")
  $icinga_use_syslog = hiera('icinga_use_syslog','1')
  $icinga_check_result_reaper_frequency = hiera('icinga_check_result_reaper_frequency','10')
  $icinga_check_result_path = hiera('icinga_check_result_path',"/var/spool/icinga/checkresults")
  $icinga_service_check_timeout = hiera('icinga_service_check_timeout','60')
  $icinga_state_retention_file = hiera('icinga_state_retention_file',"/var/spool/icinga/retention.dat")
  $icinga_dump_retained_host_service_states_to_neb = hiera('icinga_dump_retained_host_service_states_to_neb','1')
  $icinga_allow_empty_hostgroup_assignment = hiera('icinga_allow_empty_hostgroup_assignment','0')
  $icinga_service_check_timeout_state = hiera('icinga_service_check_timeout_state',"u")
  $icinga_date_format = hiera('icinga_date_format',"euro")
  $icinga_use_large_installation_tweaks = hiera('icinga_use_large_installation_tweaks','0')
  $icinga_child_processes_fork_twice = hiera('icinga_child_processes_fork_twice','1')
  $icinga_debug_file = hiera('icinga_debug_file',"/var/log/icinga/icinga.debug")
  $icinga_passwd = hiera('icinga_passwd',"/etc/icinga/passwd")
  $services_resource_dir = "${icinga_conf_dir}/services"
  $hosts_resource_dir = "${icinga_conf_dir}/hosts"
  $hostgroups_dir = "${icinga_conf_dir}/hostgroups"
  $templates_dir = "${icinga_conf_dir}/templates"
  $contacts_dir = "${icinga_conf_dir}/contacts"
  $commands_dir = "${icinga_conf_dir}/commands"

  $user = 'icinga'
  $group = 'icinga'
  $apache_user = 'apache'
  $apache_group = 'apache'
  $apache_root = '/var/www/html'
  $grafana_root = "${apache_root}/grafana"

  $service_template_default = "generic-service"
  $host_template_default = "linux-server"

  # If some node doesn't have domainname, use only the hostname
  if($::fqdn) {
    $servername = $::fqdn
  } else {
    $servername = $::hostname
  }

  # To avoid collision between puppet resources
  $resourcehost = "${project}_${servername}"

}
