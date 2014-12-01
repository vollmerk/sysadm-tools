# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class beegfs::server::storage {

  require yum::repo::beegfs

  package { 'fhgfs-storage': ensure  => installed }

  file { '/etc/fhgfs/fhgfs-storage.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/storage/$fqdn",'puppet:///modules/beegfs/storage/default'],
    require => Package['fhgfs-storage'],
  }

  service { 'fhgfs-storage':
    ensure    => true,
    enable    => true,
    subscribe => File['/etc/fhgfs/fhgfs-storage.conf'],
  }

}
