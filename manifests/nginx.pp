# doc
class librato::nginx (
  String $protocol = 'http',
  String $host = 'localhost',
  String $path = '/basic_status'
) {
  file {"${librato::plugin_config_path}/nginx.conf":
    ensure  => file,
    content => epp('librato/nginx.conf.epp', {
      'protocol' => $protocol,
      'host'     => $host,
      'path'     => $path
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
