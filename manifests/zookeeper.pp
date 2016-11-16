# doc
class librato::zookeeper (
  String $host = 'localhost',
  String $port = '2181'
) {
  file {"${librato::plugin_config_path}/zookeeper.conf":
    ensure  => file,
    content => epp('librato/zookeeper.conf.epp', {
      'host' => $host,
      'port' => $port
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
