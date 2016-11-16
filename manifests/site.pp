node default {
  if $facts['os']['family'] == 'Debian' {
    include 'apt'
    package {'apt-transport-https': }
    package {'ca-certificates': }
  }
  class {'librato':
    email => 'foo@bar.baz',
    token => '1234abcd',
  }
  include librato::logging

  class {'librato::apache':
    path => '/test-status'
  }
  include librato::docker
  include librato::elasticsearch
  include librato::haproxy
  include librato::memcached
  include librato::redis
  include librato::varnish
  include librato::zookeeper

  class {'librato::nginx':
    path => '/test-status'
  }
  class {'librato::nginx_plus':
    path => '/test-status'
  }
  class {'librato::mongodb':
    databases => ['foo', 'bar', 'baz']
  }
  class {'librato::mysql':
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
  }
  class {'librato::postgresql':
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
  }
  class {'librato::jvm':
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
  }
}
