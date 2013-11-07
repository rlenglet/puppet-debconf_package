# == Define: debconf_package
#
# Install package with debconf preseed file,
# and reconfigure when the file is updated.
#
# === Parameters
#
# [*ensure*]
#   The ensure parameter for the package
#
# [*source*]/[*content*]
#   The source or content for the debconf file
#
# === Examples
#
#  debconf_package { openssh-server:
#    ensure => present,
#    content => 'openssh-server	ssh/use_old_init_script	boolean	true
#  openssh-server	ssh/disable_cr_auth	boolean	false
#  '
#  }
#
# === Authors
#
# Romain Lenglet <romain.lenglet@berabera.info>
# Erik Dalén <erik.gustav.dalen@gmail.com>
#
# === Copyright
#
# Copyright 2012 Erik Dalén
# Copyright 2013 Romain Lenglet
#
define debconf_package (
  $ensure,
  $source=undef,
  $content=undef) {
  include debconf_package::setup

  file { "${::puppet_vardir}/debconf/${name}.debconf":
    source => $source,
    content => $content,
    owner => root,
    group => root,
    mode => "0600",
    require => File["${::puppet_vardir}/debconf"],
  }

  package { $name:
    ensure => $ensure,
    responsefile => "${::puppet_vardir}/debconf/${name}.debconf",
    require => File["${::puppet_vardir}/debconf/${name}.debconf"],
  }

  exec { "debconf-set-selections ${name}":
    command => "/usr/bin/debconf-set-selections ${puppet_vardir}/debconf/${name}.debconf",
    require => [Package[$name], File["${puppet_vardir}/debconf/${name}.debconf"]],
    subscribe => File["${puppet_vardir}/debconf/${name}.debconf"],
    refreshonly => true,
    user => root,
    group => root,
  }

  exec { "dpkg-reconfigure ${name}":
    command => "/usr/sbin/dpkg-reconfigure -fnoninteractive ${name}",
    require => Package[$name],
    subscribe => Exec["debconf-set-selections ${name}"],
    refreshonly => true,
    user => root,
    group => root,
  }
}
