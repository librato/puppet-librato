# doc
class librato::mysql (
  Optional[Array] $databases = undef
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
