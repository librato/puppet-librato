# doc
class librato::mongodb (
  String $host = 'localhost',
  String $port = '27017',
  Optional[String] $user = undef,
  Optional[String] $password = undef,
  Optional[Array] $databases = undef,
  String $mongodb_name = 'mongodb'
) {
  file {"${librato::plugin_config_path}/mongodb.conf":
    ensure  => file,
    content => epp('librato/mongodb.conf.epp', {
      'host'      => $host,
      'port'      => $port,
      'user'      => $user,
      'password'  => $password,
      'databases' => $databases,
      'name'      => $mongodb_name
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
