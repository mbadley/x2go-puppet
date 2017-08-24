class x2go {

# execute 'yum-update'
  exec { 'yum-update':                    # exec resource named 'yum-update'
  command => '/usr/bin/yum update'  # command this resource will run
}

# install x2goserver-xsession package
  package { 'x2goserver-xsession':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => installed,
}

# install x2goserver package
  package { 'x2goserver':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => installed,
}

# ensure x2gocleansessions service is running
  service { 'x2gocleansessions':
  ensure => running,
}

# install gnome
  exec { 'yum Group Install gnome':
  unless  => '/usr/bin/yum grouplist "Desktop" | /bin/grep "^Installed Groups"',
  command => '/usr/bin/yum -y groupinstall "Desktop"',
}

# install KDE
  exec { 'yum Group Install KDE':
  unless  => '/usr/bin/yum grouplist "KDE Desktop" | /bin/grep "^Installed Groups"',
  command => '/usr/bin/yum -y groupinstall "KDE Desktop"',
}
}
