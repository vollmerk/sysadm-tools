# vim: set softtabstop=2 ts=2 sw=2 expandtab:
define pkginst($pkgname,$pkgensure='installed') {

  if defined(Package[$pkgname]) == false {
    package { $pkgname: ensure  => $pkgensure }
  }


}
