# Public: Installs & configures hub
#
# Examples
#
#   include hub
class hub(
  $ensure           = 'present',
  $alias_hub_to_git = true,
  $protocol         = 'https',
  $package_name     = 'boxen/brews/hub',
) {

  case $ensure {
    present: {
      if defined_with_params(Package[gh], { 'ensure' => 'latest' }) {
        fail('The hub package is incompatible with the GH package!')
      }

      include boxen::config

      homebrew::formula { 'hub': }

      package { $package_name :
        ensure => latest,
      }

      git::config::global { 'hub.protocol':
        value => $protocol,
      }

      if $::osfamily == 'Darwin' {
        include homebrew::config

        file { "${boxen::config::envdir}/hub.sh":
          ensure => absent,
        }

        ->
        boxen::env_script { 'hub':
          content  => template('hub/env.sh.erb'),
          priority => lower
        }
      }
    }

    absent: {
      package { $package_name :
        ensure => absent
      }

      boxen::env_script { 'hub':
        ensure   => absent,
        priority => lower,
        content  => 'this is a hack',
      }
    }

    default: {
      fail('Hub#ensure must be present or absent!')
    }

  }

}
