# vim: set softtabstop=2 ts=2 sw=2 expandtab:
class yum::repo::beegfs {

  yumrepo { 'BeeGFS':
    name      => 'BeeGFS',
    descr     => 'BeeGFS/FHGFS Repository',
    baseurl   => 'http://www.fhgfs.com/release/fhgfs_2014.01/dists/rhel6',
    enabled   => '1',
    gpgcheck  => '0',
  }

}
