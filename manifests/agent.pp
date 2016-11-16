# doc
class librato::agent inherits librato {
  package {'collectd-core':
    ensure => $librato::version
  }

  service {'collectd':
    ensure    => running,
    enable    => true,
    subscribe => Package[collectd-core]
  }

  file {"${librato::config_base}/collectd.conf":
    ensure  => file,
    content => epp('librato/collectd.conf.epp', {
      'hostname'           => $librato::hostname,
      'fqdn_lookup'        => $librato::fqdn_lookup,
      'interval'           => $librato::interval,
      'plugin_config_path' => $librato::plugin_config_path
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd]
  }

  file {"${librato::plugin_config_path}/librato.conf":
    ensure  => file,
    content => epp('librato/librato.conf.epp', {
      'email' => $librato::email,
      'token' => $librato::token
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd]
  }

  $default_plugins = $librato::default_plugins

  $default_plugins.each |String $plugin| {
    file {"${librato::plugin_config_path}/${plugin}.conf":
      ensure => file,
      source => "puppet:///modules/librato/${plugin}.conf",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      notify => Service[collectd]
    }
  }
}
