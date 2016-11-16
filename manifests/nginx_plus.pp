# doc
class librato::nginx_plus (
  String $protocol = 'http',
  String $host = 'localhost',
  String $path = '/basic_status',
  Boolean $verbose = false
) {
  file {"${librato::plugin_config_path}/nginx_plus.conf":
    ensure  => file,
    content => epp('librato/nginx_plus.conf.epp', {
      'protocol' => $protocol,
      'host'     => $host,
      'path'     => $path,
      'verbose'  => $verbose
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
