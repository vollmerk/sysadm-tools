# vim: set softtabstop=2 ts=2 sw=2 expandtab:
# Adding a module to the system
define modulefile($appname ='', $appversion='') {

  # First check and make sure the dir we need is there
  if ! defined(File["/opt/share/modules/$appname"]) {
    file { "/opt/share/modules/$appname":
      ensure  => directory,
      mode    => '0755',
    }
  }

  # Check and see if it's already there (like from a compute node)
  if $node_type == 'compute' {
    file { "/opt/share/modules/$appname/$appversion":
      audit => all,
    }
  }
  else {
    file { "/opt/share/modules/$appname/$appversion":
      ensure  => file,
      mode    => '0644',
      source  => "puppet:///modules/core/modules/$appname/$appversion",
      require => File["/opt/share/modules/$appname"],
    }
  }

} # End define add
