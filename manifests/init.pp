# Public: Installs & configures hub
#
# Examples
#
#   include hub
class hub(
  $ensure = present,
) {

  case $ensure {
    present: {
      if defined_with_params(Package[gh], { 'ensure' => 'latest' }) {
        fail('The hub package is incompatible with the GH package!')
      }

      include boxen::config

      package { 'hub':
        ensure => latest
      }

      git::config::global { 'hub.protocol':
        value => 'https'
      }

      if $::osfamily == 'Darwin' {
        include homebrew::config

        file { "${boxen::config::envdir}/hub.sh":
          content => template('hub/env.sh.erb')
        }
      }
    }

    absent: {
      package { 'hub':
        ensure => absent
      }

      file { "${boxen::config::envdir}/hub.sh":
        ensure => absent
      }
    }

    default: {
      fail("Hub#ensure must be present or absent!")
    }

  }

}
