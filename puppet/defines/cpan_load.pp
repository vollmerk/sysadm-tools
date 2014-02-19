# vim: set softtabstop=2 ts=2 sw=2 expandtab:
define cpan_load($name='') {
  exec { "cpan_load_${name}":
    command => "perl -MCPAN -e '\$ENV{PERL_MM_USE_DEFAULT}=1; CPAN::Shell->install(\"${name}\")'",
    onlyif  => "test `perl -M${name} -e 'print 1' 2>/dev/null || \\ echo 0` == '0'",
  }
}
