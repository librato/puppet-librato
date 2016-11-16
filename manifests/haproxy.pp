# doc
class librato::haproxy (
  String $socket_file = '/run/haproxy/admin.sock',
  Array $proxies = ['server', 'frontend', 'backend']
) {
  file {"${librato::plugin_config_path}/haproxy.conf":
    ensure  => file,
    content => epp('librato/haproxy.conf.epp', {
      'socket_file' => $socket_file,
      'proxies'     => $proxies
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
