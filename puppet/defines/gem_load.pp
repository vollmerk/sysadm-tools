# vim: set softtabstop=2 ts=2 sw=2 expandtab:
define gem_load($name='',$version='') {
  if $version == '' {
    $versionstring = ''
  }
  else {
    $versionstring = "-v '${version}'"
  }

  exec { "gem_load_${name}":
    command => "gem install ${name} ${versionstring}",
    unless  => "gem list | tr '[()]' ' ' | grep '${name}  ${version}'",
  }
}
