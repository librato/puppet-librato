# doc
class librato::elasticsearch (
  String $protocol = 'http',
  String $host = 'localhost',
  String $port = '9200',
  Optional[String] $cluster_name = undef,
  Boolean $verbose = true
) {
  file {"${librato::plugin_config_path}/elasticsearch.conf":
    ensure  => file,
    content => epp('librato/elasticsearch.conf.epp', {
      'protocol'     => $protocol,
      'host'         => $host,
      'port'         => $port,
      'cluster_name' => $cluster_name,
      'verbose'      => $verbose
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
