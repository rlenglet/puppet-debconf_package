class debconf_package::setup {
  file { "${::puppet_vardir}/debconf":
    ensure => directory,
    purge  => true,
    owner  => root,
    group  => root,
    mode   => '0700',
  }
}
