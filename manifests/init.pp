# doc
class librato (
  String $email = nil,
  String $token = nil,
  String $repo_url = 'https://packagecloud.io/librato',
  String $repo_base = 'librato-collectd',
  String $deb_version = '5.5.0-librato51.251',
  String $redhat_version = '5.5.0_librato51.251',
  String $config_base = '/opt/collectd/etc',
  String $plugin_config_path = '/opt/collectd/etc/collectd.conf.d',
  String $hostname = $facts['fqdn'],
  Boolean $fqdn_lookup = false,
  Integer $interval = 60,
  Array $default_plugins = ['cpu', 'df', 'disk', 'swap', 'memory', 'load']
) {
  Class[librato::repo] ->
  Class[librato::agent]

  $version = $facts['os']['name'] ? {
    'RedHat' => $redhat_version,
    'Amazon' => $redhat_version,
    'CentOS' => $redhat_version,
    'Fedora' => $redhat_version,
    'Debian' => $deb_version,
    'Ubuntu' => $deb_version
  }

  include 'librato::repo'
  include 'librato::agent'
}
