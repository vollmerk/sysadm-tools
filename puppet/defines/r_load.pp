# vim: set softtabstop=2 ts=2 sw=2 expandtab:

define r_load($pkgname='') {
  exec { "r_load_${pkgname}":
    command => "R -e 'options(repos=c(\"http://mirror.its.dal.ca/cran\")); install.packages(c(\"${pkgname}\"))'",
    unless  => "R -e '\"${pkgname}\" %in% rownames(installed.packages())' | grep TRUE",
  }
}
