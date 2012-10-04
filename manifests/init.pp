# Public: Installs & configures hub
#
# Examples
#
#   include hub
class hub {
  require boxen::config

  package { 'hub':
    ensure => latest
  }

  git::config::global { 'hub.protocol':
    value => 'https'
  }

  file { "${boxen::config::envdir}/hub.sh":
    source  => 'puppet:///modules/hub/hub.sh',
    require => File[$boxen::config::envdir]
  }
}
