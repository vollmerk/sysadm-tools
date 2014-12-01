# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class beegfs::client {

  require yum::repo::beegfs

  package { 'fhgfs-client': ensure  => installed }
  package { 'fhgfs-helperd': ensure => installed }
  package { 'fhgfs-utils':  ensure  => installed }

  file { '/etc/fhgfs/fhgfs-mounts.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/mounts/$fqdn","puppet:///modules/beegfs/mounts/$domain",'puppet:///modules/beegfs/mounts/default'],
    require => Package['fhgfs-client'],
  }

  file { '/etc/fhgfs/fhgfs-client-autobuild.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/client/$fqdn.build","puppet:///modules/beegfs/client/$domain.build",'puppet:///modules/beegfs/client/default.build'],
    require => Package['fhgfs-client'],
  }

  file { '/etc/fhgfs/fhgfs-client.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/client/$fqdn","puppet:///modules/beegfs/client/$domain",'puppet:///modules/beegfs/client/default'],
    require => Package['fhgfs-client'],
  }

  service { 'fhgfs-client':
    ensure    => true,
    hasstatus => true,
    enable    => true,
    subscribe => [File['/etc/fhgfs/fhgfs-client.conf'],File['/etc/fhgfs/fhgfs-mounts.conf']],
    require   => Service['fhgfs-helperd'],
  }

  service { 'fhgfs-helperd':
    ensure    => true,
    hasstatus => true,
    enable    => true,
    subscribe => [File['/etc/fhgfs/fhgfs-client.conf']],
  }

}
