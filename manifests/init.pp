class hub {
  require github::config

  package { 'hub':
    ensure => latest
  }

  git::config::global { 'hub.protocol':
    value => 'https'
  }

  file { "${github::config::envdir}/hub.sh":
    source  => 'puppet:///modules/hub/hub.sh',
    require => File[$github::config::envdir]
  }
}
