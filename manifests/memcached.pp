# doc
class librato::memcached (
  String $host = 'localhost',
  String $port = '11211'
) {
  file {"${librato::plugin_config_path}/memcached.conf":
    ensure  => file,
    content => epp('librato/memcached.conf.epp', {
      'host' => $host,
      'port' => $port,
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
