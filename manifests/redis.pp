# doc
class librato::redis (
  String $host = 'localhost',
  String $port = '6379',
  String $timeout = '2000'
) {
  file {"${librato::plugin_config_path}/redis.conf":
    ensure  => file,
    content => epp('librato/redis.conf.epp', {
      'host'    => $host,
      'port'    => $port,
      'timeout' => $timeout
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
