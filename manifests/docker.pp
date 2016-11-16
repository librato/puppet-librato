# doc
class librato::docker (
  String $protocol = 'http',
  String $host = 'localhost',
  String $port = '2735'
) {
  file {"${librato::plugin_config_path}/docker.conf":
    ensure  => file,
    content => epp('librato/docker.conf.epp', {
      'protocol' => $protocol,
      'host'     => $host,
      'port'     => $port
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
