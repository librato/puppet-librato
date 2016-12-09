# doc
class librato::postgresql (
  String $socket_file = '/var/run/postgresql',
  String $user = 'postgresql',
  Optional[Array] $databases = undef
) {
  file {"${librato::plugin_config_path}/postgresql.conf":
    ensure  => file,
    content => epp('librato/postgresql.conf.epp', {
      'socket_file' => $socket_file,
      'user'        => $user,
      'databases'   => $databases
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
