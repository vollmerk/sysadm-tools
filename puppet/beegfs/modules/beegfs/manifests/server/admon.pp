# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class beegfs::server::admon {

  require yum::repo::beegfs

  package { 'fhgfs-admon': ensure  => installed }

  file { '/etc/fhgfs/fhgfs-admon.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/beegfs/admon/$fqdn",
    require => Package['fhgfs-admon'],
  }


  service { 'fhgfs-admon':
    ensure    => true,
    enable    => true,
    subscribe => File['/etc/fhgfs/fhgfs-admon.conf'],
  }

}
