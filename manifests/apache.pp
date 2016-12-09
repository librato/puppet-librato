# doc
class librato::apache (
  String $protocol = 'http',
  String $host = 'localhost',
  String $path = '/server-status',
  Optional[String] $user = undef,
  Optional[String] $password = undef
) {
  file {"${librato::plugin_config_path}/apache.conf":
    ensure  => file,
    content => epp('librato/apache.conf.epp', {
      'protocol' => $protocol,
      'host'     => $host,
      'path'     => $path,
      'user'     => $user,
      'password' => $password
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
