# librato

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with librato](#setup)
    * [What librato affects](#what-librato-affects)
    * [Beginning with librato](#beginning-with-librato)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module installs and configures the Librato Agent and plugins. It's designed to work with Puppet 4.x.

## Setup

### What `librato` affects

This module installs and manages the Librato Agent via Librato's PackageCloud repo. Due to the nature of the underlying tool (collectd) there will be many dependencies installed during this installation--this is normal.

If you are running this on Debian or Ubuntu, an apt package pin will be set up for `collectd` and `collectd-core` packages to pull from the Librato Agent repo.

### Beginning with `librato`    

The bare minimum setup will install the Librato Agent on a node and send the default OS-level metrics to Librato:

```ruby
class {'librato':
  email => 'foo@bar.baz',
  token => '1234abcd',
}
```

The `email` and `token` paremeters are required. You will find these in your Librato account.

If you want logging (we recommend it), include the [`librato::logging`](#libratologging) class.

## Usage

### Using custom or upstream plugins

To use your own custom or upstream collectd plugin, simply have another module drop the config into `/opt/collectd/etc/collectd.conf.d/` and any custom plugins into `/opt/collectd/share/collectd/`.

## Reference

### Classes

#### Public Classes

* [`librato`](#librato): Main class. Configure global options here.
* [`librato::logging`](#libratologging): Configures logging
* [`librato::apache`](#libratoapache): Configures the Apache plugin
* [`librato::docker`](#libratodocker): Configures the Docker plugin
* [`librato::elasticsearch`](#libratoelasticsearch): Configures the ElasticSearch plugin
* [`librato::haproxy`](#libratohaproxy): Configures the haproxy plugin
* [`librato::jvm`](#libratojvm): Configures the JVM plugin
* [`librato::memcached`](#libratomemcached): Configures the Memcached plugin
* [`librato::mongodb`](#libratomongodb): Configures the MongoDB plugin
* [`librato::mysql`](#libratomysql): Configures the MySQL plugin
* [`librato::nginx`](#libratonginx): Configures the NGINX plugin
* [`librato::nginx_plus`](#libratonginx_plus): Configures the NGINX Plus plugin
* [`librato::postgresql`](#libratopostgresql): Configures the PostgreSQL plugin
* [`librato::redis`](#libratoredis): Configures the Redis plugin
* [`librato::varnish`](#libratovarnish): Configures the Varnish plugin
* [`librato::zookeeper`](#libratozookeeper): Configures the Zookeeper plugin

#### Private Classes

* `librato::agent`: Private class for installation and configuration of the Agent itself
* `librato::repo`: Private class for the Agent's repo


### `librato`

#### Parameters

##### `email`
The email to use for sending metrics. Use in conjunction with `token`. This parameter is *required*. Valid options: `string`. Default: `nil`.

##### `token`
The API token to use for sending metrics. Use in conjunction with `email`. This parameter is *required*. Valid options: `string`. Default: `nil`.

##### `repo_url`
The base URL for the packages. Valid options: `string`. Default: `https://packagecloud.io/librato/`.

##### `repo_base`
The repo base to use. Valid options: `string`. Default: `librato-collectd`.

##### `deb_version`
The version of the Librato Agent to install on Debian/Ubuntu. Valid options: `string`. Default: `5.5.0-librato51.251`

##### `redhat_version`
The version of the Librato Agent to install on RedHat/CentOS/Amazon/Fedora. Valid options: `string`. Default: `5.5.0_librato51.251`

##### `config_base`
The base path for collectd's config files. Valid options: `string`. Default: `/opt/collectd/etc`.

##### `plugin_config_path`
The path for collectd's plugin configs. Valid options: `string`. Default: `/opt/collectd/etc/collectd.conf.d`.

##### `hostname`
The hostname to use for the node. Valid options: `string`. Default: `$facter['fqdn']`.

##### `fqdn_lookup`
Perform an FQDN lookup or not. Valid options: `boolean`. Default: `false`.

##### `interval`
The global plugin polling interval in seconds. Valid options: `integer`. Default: `60`.

##### `default_plugins`
An array of default plugins to include. Valid options: `array`. Default: `['cpu', 'df', 'disk', 'swap', 'memory', 'load']`.


### `librato::logging`

#### Parameters

##### `use_log_file`
Write collectd logs to a file. Valid options: `boolean`. Default: `true`.

##### `use_syslog`
Write collectd logs to syslog. Valid options: `boolean`. Default: `false`.

##### `use_logstash`
Write collectd logs to a logstash-formatted file. Valid options: `boolean`. Default: `false`.

##### `log_file_log_level`
The log level to use for `log_file`. Valid options: `string`. Default: `info`.

##### `log_file_filename`
The filename to use for `log_file`. Valid options: `string`. Default: `/opt/collectd/var/log/collectd.log`.

##### `log_file_timestamp`
Use timestamps in the log file or not. Valid options: `boolean`. Default: `true`.

##### `log_file_print_severity`
Include severity levels in the log file or not. Valid options: `boolean`. Default: `true`.

##### `syslog_log_level`
The log level to use for `syslog`. Valid options: `string`. Default: `info`.

##### `logstash_log_level`
The log level to use for `logstash`. Valid options: `string`. Default: `info`.

##### `logstash_filename`
The file name to use for `logstash`. Valid options: `string`. Default: `/opt/collectd/var/log/collectd.json.log`


### `librato::apache`

#### Parameters

##### `protocol`
The protocol to use. Valid options: `string` (`http`, `https`). Default: `http`.

##### `host`
The hostname to use. Valid options: `string`. Default: `localhost`.

##### `path`
The path to the status page. `?auto` is automatically appended, so no need to include it. Valid options: `string`. Default:`/server-status`.

##### `user`
The username to use for password-protected status pages. Valid options: `string`. Default: `nil`.

##### `password`
The password to use for password-protected status pages. Valid options: `string`. Default: `nil`.


### `librato::docker`

#### Parameters

##### `protocol`
The protocol to use. Valid options: `string` (`http`, `https`). Default: `http`.

##### `host`
The Docker hostname. Valid options: `string`. Default: `localhost`.

##### `port`
The Docker port. Valid options: `string`. Default: `2735`



### `librato::elasticsearch`

#### Parameters

##### `protocol`
The protocol to use. Valid options: `string` (`http`, `https`). Default: `http`.

##### `host`
The ElasticSearch hostname. Valid options: `string`. Default: `localhost`.

##### `port`
The ElasticSearch port. Valid options: `string`. Default: `9200`.

##### `cluster_name`
The ElasticSearch cluster name, if set. Valid options: `string`. Default: `nil`.

##### `verbose`
Verbosity trigger of the plugin. Valid options: `boolean`. Default: `true`.



### `librato::haproxy`

#### Parameters

##### `socket_file`
The HAProxy socket file. Valid options: `string`. Default: `/run/haproxy/admin.sock`.

##### `proxies`
The default proxies to collect. Valid options: `array`. Default: `['server', 'frontend', 'backend']`.


### `librato::jvm`

#### Parameters

##### `host`
The JVM host. Valid options: `string`. Default: `localhost`.

##### `service_url`
The JVM service URL to query. Valid options: `string`. Default: `service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi`.

##### `mbeans`
Additional mbeans to collect. Valid options: `array`. Default: `nil`.

Format of the array is:
```ruby
mbeans => [
  {
    'name'            => 'foo',
    'object_name'     => 'objname',
    'instance_prefix' => 'prefix',
    'instance_from'   => 'from',
    'values'          => [
      {
	'type'      => 'type',
	'table'     => true,
	'attribute' => 'att'
      },
      {
	'type'      => 'type',
	'table'     => true,
	'attribute' => 'att'
      }
    ]
  }
]
```


### `librato::memcached`

#### Parameters

##### `host`
The memcached hostname. Valid options: `string`. Default: `localhost`.

##### `port`
The memcached port. Valid options: `string`. Default: `11211`.



### `librato::mongodb`

#### Parameters

##### `host`
The MongoDB hostname. Valid options: `string`. Default: `localhost`.

##### `port`
The MongoDB port. Valid options: `string`. Default: `27017`.

##### `user`
The MongoDB username to connect with. Valid options: `string`. Default: `nil`.

##### `password`
The MongoDB password to connect with. Valid options: `string`. Default: `nil`.

##### `databases`
Databases to collect metrics for. Valid options: `array`. Default: `nil`. `admin` database is automatically included in the array.

##### `name`
Set the name of the plugin instance. Valid options: `string`. Default: `mongodb`.


### `librato::mysql`

#### Parameters

##### `databases`
Databases to collect metrics for. Valid options: `array`. Default: `nil`.

Format of the array:
```ruby
databases => [
  {
    'name'         => 'mydb',
    'host'         => 'localhost',
    'port'         => 3306,
    'user'         => 'foo',
    'password'     => 'baz',
    'innodb_stats' => true
  }
]
```

### `librato::nginx`

#### Parameters

##### `protocol`
The protocol to use. Valid options: `string` (`http`, `https`). Default: `http`.

##### `host`
The hostname to use. Valid options: `string`. Default: `localhost`.

##### `path`
The path to the status page. Valid options: `string`. Default: `/basic_status`.



### `librato::nginx_plus`

#### Parameters

##### `protocol`
The protocol to use. Valid options: `string` (`http`, `https`). Default: `http`.

##### `host`
The hostname to use. Valid options: `string`. Default: `localhost`.

##### `path`
The path to the status page. Valid options: `string`. Default: `/basic_status`.

##### `verbose`
Verbosity on/off for the plugin. Valid options: `boolean`. Default: `false`.



### `librato::postgresql`

#### Parameters

##### `socket_file`
The PostgreSQL socket file. Valid options: `string`. Default: `/var/run/postgresql`.

##### `user`
The PostgreSQL user to connect as. Valid options: `string`. Default: `postgresql`.

##### `databases`
The databases to collect metrics for. Valid options: `array`. Default: `nil`.

The format of the array is:
```ruby
databases => [
  {
    'name'     => 'mydb',
    'instance' => 'baz',
    'host'     => 'localhost',
    'port'     => 5432,
    'user'     => 'foo',
    'password' => 'baz',
  }
]
```

### `librato::redis`

#### Parameters

##### `host`
The Redis hostname. Valid options: `string`. Default: `localhost`.

##### `port`
The Redis port. Valid options: `string`. Default: `6379`.

##### `timeout`
The timeout for connecting to Redis in milliseconds. Valid options: `string`. Default: `2000`.


### `librato::varnish`

#### Parameters

  Varnish has no configurable parameters.

### `librato::zookeeper`

#### Parameters

##### `host`
The ZooKeeper hostname. Valid options: `string`. Defaults: `localhost`.

##### `port`
The ZooKeeper port. Valid options: `string`. Default: `2181`.


## Limitations

### Supported Platforms

* RHEL 6 / CentOS 6
* RHEL 7 / CentOS 7
* Fedora 23
* Amazon Linux 2016.03
* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 15.04
* Ubuntu 15.10
* Ubuntu 16.04
* Debian 7
* Debian 8

### Supported Puppet Versions

Due to the usage of Puppet EPP templates, this module only works on Puppet 4.x.

## Development

### Testing

Integration tests utilize `kitchen-puppet` and `serverspec`. To run the test suite:

1. Run `bundle install`
2. Run `kitchen test`

Style and syntax tests can be run with:

* `puppet-lint manifests/*`
* `puppet parser validate manifests/*`
* `puppet epp validate templates/*`

No unit tests have been written at this time.

All contributions must pass the tests above.

`manifests/site.pp` is currently setup for all of the plugins.

#### Testing Amazon Linux

Testing Amazon Linux through `test-kitchen` requires a bit more setup:

1. Ensure `kitchen-ec2` is installed: `gem install kitchen-ec2`
2. Update `.kitchen.yml` to have the correct AWS key ID you're going to use
3. Set `security_group_ids` in the driver section to include a security group accessible from your laptop. Not setting this will use the `default`    security group.
4. Set `transport.ssh_key` to the path of your SSH key. It looks for `id_rsa` by default.

#### Testing Fedora

`kitchen-puppet` has a limitation around Puppet installation. To work around the issue, install `puppet-agent` manually on Fedora then run `kitchen verify fedora-23` to run the test suite.

## Release Notes/Contributors/Etc.

**Author:** Mike Julian (@mjulian)
