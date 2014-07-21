#debconf_package

####Table of Contents

1. [Overview - What is the debconf_package module?](#overview)
2. [Module Description - What does the debconf_package module do?](#module-description)
3. [Setup - The basics of getting started with debconf_package](#setup)
    * [What debconf_package affects](#what-debconf_package-affects)
    * [Beginning with debconf_package](#beginning-with-debconf_package)
4. [Usage - The custom type available for configuration](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors](#contributors)
8. [License](#license)

##Overview

Configures Debian/Ubuntu packages using debconf preseed files and reconfigures
them when the preseed files are modified.

##Module Description

The `debconf_package` module adds a type that installs and configures a
Debian/Ubuntu package using a debconf preseed file and executes
`dpkg-reconfigure` when the preseed file is updated.

##Setup

The best way to install this module is by executing the following command on
your puppet master or local Puppet install:

    $ puppet module install [--modulepath <path>] rlenglet/debconf_package

The above command also includes the optional argument to specify your puppet
master's `modulepath` as the location to install the module.

###What debconf_package affects

* Debian packages.
* Debian debconf preseed selections.

###Beginning with debconf_package

The `::debconf_package` type is a simplified version of the standard
`package` type, which optionally allows specifying debconf selections
in the `content` or `source` attribute.

Specify the optional `ensure` and `content` or `source` attributes:

    debconf_package { openssh-server:
      ensure => present,
      content => 'openssh-server	ssh/use_old_init_script	boolean	true
    openssh-server	ssh/disable_cr_auth	boolean	false
    '
    }

##Usage

###Defined Type: `debconf_package`

####Parameters

#####`ensure`

The `ensure` attribute for the package.  Accepts the same values as in
the standard `package` type.

#####`source`

The file to use as source for the debconf preseed file.  Mutually
exclusive with `content`.

#####`content`

The contents of the debconf preseed file.  Mutually exclusive with
`source`.

##Limitations

This module is compatible only with Debian and Ubuntu.

##Development

Feedback and contributions are appreciated, in the form of issues or
pull requests on [the Github project
page](https://github.com/rlenglet/puppet-debconf_package).

##Contributors

The `debconf_package` module is based on [Erik Dalén's
`preseed_package`
module](https://github.com/dalen/puppet-preseed_package).

##License

Copyright 2012 Erik Dalén<br/>
Copyright 2013, 2014 Romain Lenglet

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.
