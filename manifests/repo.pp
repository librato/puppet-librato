# Doc
class librato::repo inherits librato {
  $platform = downcase($facts['os']['name'])

  case $platform {
    'debian', 'ubuntu': {
      require 'apt'

      apt::source {"librato_${librato::repo_base}":
        location => "${librato::repo_url}/${librato::repo_base}/${platform}/",
        repos    => 'main',
        include  => {
          'src' => true,
          'deb' => true,
        },
      }

      apt::key {'packagecloud':
        id     => 'C2E73424D59097AB',
        source => 'https://packagecloud.io/gpg.key'
      }

      apt::pin { 'collectd':
        packages => 'collectd',
        priority => 1001,
        label    => 'librato-collectd'
      }
      apt::pin { 'collectd-core':
        packages => 'collectd-core',
        priority => 1001,
        label    => 'librato-collectd'
      }
    }

    'centos', 'redhat', 'amazon': {
      require 'epel'

      if $platform == 'amazon' {
        $repo_base = 'librato-amazonlinux-collectd'

        yumrepo {"librato_${repo_base}":
          descr    => "librato_${repo_base}",
          baseurl  => "${librato::repo_url}/${repo_base}/el/6/\$basearch",
          gpgcheck => no,
          gpgkey   => 'https://packagecloud.io/gpg.key'
        }
      }
      else {
        yumrepo {"librato_${librato::repo_base}":
          descr    => "librato_${librato::repo_base}",
          baseurl  => "${librato::repo_url}/${librato::repo_base}/el/\$releasever/\$basearch",
          gpgcheck => no,
          gpgkey   => 'https://packagecloud.io/gpg.key'
        }
      }
    }

    'fedora': {
      yumrepo {"librato_${librato::repo_base}":
        descr    => "librato_${librato::repo_base}",
        baseurl  => "${librato::repo_url}/${librato::repo_base}/fedora/\$releasever/\$basearch",
        gpgcheck => no,
        gpgkey   => 'https://packagecloud.io/gpg.key'
      }
    }

    default: {
      notify {"Unsupported operating system: ${facts['os']['name']}":
        loglevel => err
      }
    }
  }
}
