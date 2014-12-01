# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class beegfs::server::management {

  require yum::repo::beegfs

  package { 'fhgfs-mgmtd': ensure  => installed }

  file { '/etc/fhgfs/fhgfs-mgmtd.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => ["puppet:///modules/beegfs/mgmtd/$fqdn",'puppet://modules/beegfs/mgmtd/default'],
    require => Package['fhgfs-mgmtd'],
  }

  service { 'fhgfs-mgmtd':
    ensure    => true,
    enable    => true,
    subscribe => File['/etc/fhgfs/fhgfs-mgmtd.conf'],
    require   => Package['fhgfs-mgmtd'],
  }

}
