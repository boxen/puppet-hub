# Hub Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-hub.png)](https://travis-ci.org/boxen/puppet-hub)

Install [Hub](https://github.com/defunkt/hub), a GitHub-focused `git` wrapper.

## Usage

```puppet
include hub
```

## Configuration

You can use hiera to configure the following:

* `hub::protocol`: one of `'https'` or `'git'`
  Protocol for `hub` to use by default when cloning from github like `hub clone user/repo`. Defaults to `'https'`
* `hub::alias_hub_to_git`: boolean
  Whether or not to set a shell alias `git=hub`

## Required Puppet Modules

* `boxen`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
