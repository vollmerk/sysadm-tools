# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class beegfs::server::metadata {

  require yum::repo::beegfs

  package { 'fhgfs-meta': ensure  => installed }

  file { '/etc/fhgfs/fhgfs-meta.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/meta/$fqdn",'puppet:///modules/beegfs/meta/default'],
    require => Package['fhgfs-meta'],
  }

  service { 'fhgfs-meta':
    ensure    => true,
    enable    => true,
    subscribe => File['/etc/fhgfs/fhgfs-meta.conf'],
  }

}
