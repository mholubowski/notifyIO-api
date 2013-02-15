# -*- Puppet -*- mode

Exec {
  path=>'/usr/bin:/bin',
  logoutput=>on_failure
}

file {'/tmp/hello world':
  ensure => present,
  content => 'Hello World'
}

package { 'sinatra':
    ensure   => 'installed',
    provider => 'gem',
}

package { 'haml':
    ensure   => 'installed',
    provider => 'gem',
}
