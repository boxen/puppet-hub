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
    content => template('hub/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }
}
