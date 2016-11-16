# doc
class librato::mysql (
  Array $databases = []
) {
  file {"${librato::plugin_config_path}/mysql.conf":
    ensure  => file,
    content => epp('librato/mysql.conf.epp', {
      'databases' => $databases
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
