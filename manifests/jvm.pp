# doc
class librato::jvm (
  String $service_url = 'service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi',
  String $host = 'localhost',
  Array $mbeans = []
) {
  file {"${librato::plugin_config_path}/jvm.conf":
    ensure  => file,
    content => epp('librato/jvm.conf.epp', {
      'service_url' => $service_url,
      'host'        => $host,
      'mbeans'      => $mbeans,
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
