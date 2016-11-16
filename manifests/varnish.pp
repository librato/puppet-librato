# doc
class librato::varnish {
  file {"${librato::plugin_config_path}/varnish.conf":
    ensure  => file,
    source  => 'puppet:///modules/librato/varnish.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
