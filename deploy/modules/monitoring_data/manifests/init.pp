class monitoring_data (
  $database,
  $importedflag,
  $sqldump = '/vagrant/monitoring.sql',
)
{

  postgresql::server::db { $database:
    user     => $database,
    password => postgresql_password($database, $database),
    before => Exec ["Import_monitoring_data"],
  }

  exec { "Import_monitoring_data":
    user    => "postgres",
    creates => $importedflag,
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "psql -f ${sqldump} ${database} && touch $importedflag",
    timeout => 3600,
    require => Service['postgresql'],
  }

}
