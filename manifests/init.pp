# Public: Installs & configures hub
#
# Examples
#
#   include hub
class hub(
  $ensure           = 'present',
  $alias_hub_to_git = true,
  $protocol         = 'https',
) {

  case $ensure {
    present: {
      if defined_with_params(Package[gh], { 'ensure' => 'latest' }) {
        fail('The hub package is incompatible with the GH package!')
      }
      include boxen::config

      $version = '1.11.2'
      $download_uri = "https://codeload.github.com/github/hub/zip/v${version}"

      $install_command = join([
        # remove any previous attempts
        'rm -rf /tmp/hub*',
        # download the zip to tmp
        "curl ${download_uri} > /tmp/hub.zip",
        # extract the zip to tmp
        'mkdir /tmp/hub',
        'unzip -o /tmp/hub.zip -d /tmp/hub',
        # run the install
        'cd /tmp/hub',
        'rake install'
      ], ' && ')

      exec {
        "install hub":
          command => $install_command,
          unless  => "test -x hub && hub version | grep 'hub version ${version}'",
          user    => $::boxen_user
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
      package { 'hub':
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
