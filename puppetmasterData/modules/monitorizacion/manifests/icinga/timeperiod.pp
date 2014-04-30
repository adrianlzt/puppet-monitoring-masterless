define monitorizacion::icinga::timeperiod (
  $alias = $name,
  $monday    = undef,
  $tuesday   = undef,
  $wednesday = undef,
  $thursday  = undef,
  $friday    = undef,
  $saturday  = undef,
  $sunday    = undef,
)
{
  include monitorizacion::params

  $target = "$monitorizacion::params::icinga_root_dir/conf.d/timeperiods.cfg"

  nagios_timeperiod { $name:
    ensure    => present,
    alias     => $alias,
    monday    => $monday,
    tuesday   => $tuesday,
    wednesday => $wednesday,
    thursday  => $thursday,
    friday    => $friday,
    saturday  => $saturday,
    sunday    => $sunday,
    target    => $target,
    require   => File[$target],
    before    => Anchor['conf-after-run'],
    notify    => Service['icinga'],
  }
}
