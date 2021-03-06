class torquebox {
  $tb_home = "/opt/torquebox"
  $tb_version = "2.1.2"
  package { unzip:
    ensure => present
  }

  exec { "download_tb":
    command => "wget -O /tmp/torquebox.zip http://torquebox.org/release/org/torquebox/torquebox-dist/2.1.2/torquebox-dist-2.1.2-bin.zip",
    path => $path,
    creates => "/tmp/torquebox.zip",
    unless => "ls /opt | grep torquebox-${tb_version}",
    require => [Package["openjdk-6-jdk"], User[torquebox]]
  }

  exec { "unpack_tb" :
    command => "unzip /tmp/torquebox.zip -d /opt",
    path => $path,
    creates => "${tb_home}-${tb_version}",
    require => [Exec["download_tb"], Package[unzip]]
  }

  file { $tb_home:
    ensure => link,
    target => "${tb_home}-${tb_version}",
    require => Exec["unpack_tb"]
  }

  user { "torquebox":
    ensure => present,
    managehome => true,
    system => true
  }

  exec { copy_ssh_key :
    command => "cp -R /home/vagrant/.ssh /home/torquebox/.ssh",
    path => $path,
    creates => "/home/torquebox/.ssh",
    require => User[torquebox]
  }
  file { "/home/torquebox/.ssh":
    ensure => directory,
    owner => torquebox,
    group => torquebox,
    recurse => true,
    require => Exec[copy_ssh_key]
  }

  exec { "chown_tb_home":
    command => "chown -RH torquebox:torquebox ${tb_home}-${tb_version}",
    path => $path,
    require => [File[$tb_home], User[torquebox]]
  }

  exec { "install_gems":
    cwd => "${tb_home}/jruby/lib/ruby/gems/1.8/cache",
    command => "/opt/jruby/bin/jruby -S gem install *.gem",
    path => $path,
    require => [File[$tb_home], User["torquebox"]]
  }

  exec { "upstart_install":
    cwd => $tb_home,
    command => "/opt/jruby/bin/jruby -S rake torquebox:upstart:install",
    environment => ["JBOSS_HOME=${tb_home}/jboss", "TORQUEBOX_HOME=${tb_home}",
                    'SERVER_OPTS="-b=0.0.0.0"', "JRUBY_HOME=/opt/jruby"],
    creates => "/etc/init/torquebox.conf",
    require => [Exec["install_gems"], File[$tb_home], User["torquebox"]]
  }

  exec { "upstart_start":
    cwd => $tb_home,
    command => "/opt/jruby/bin/jruby -S rake torquebox:upstart:start",
    environment => ["JBOSS_HOME=${tb_home}/jboss", "TORQUEBOX_HOME=${tb_home}", "JRUBY_HOME=/opt/jruby"],
    require => Exec["upstart_install"]
  }
}