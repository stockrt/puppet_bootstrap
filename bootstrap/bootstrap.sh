#!/bin/bash

FACTER_VERSION="1.5.8"
PUPPET_VERSION="2.6.4"

DOWNLOAD_CACHE="/tmp/pp"
BASEDIR="$(dirname $0)"
WGET="wget -c -N"

if [[ "$USER" != "root" ]]
then
    echo "You must run this script as root."
    exit 1
fi

os_install() {
    package="$1"
    echo "Installing with OS native package tool: $package"
    (which port >/dev/null 2>&1 && port install $package) || \
    (which yum >/dev/null 2>&1 && yum -y install $package) || \
    (which apt-get >/dev/null 2>&1 && apt-get -y install $package)
}

# ruby
os_install ruby

# wget
os_install wget

# download cache dir
mkdir $DOWNLOAD_CACHE >/dev/null 2>&1

# facter
cd $DOWNLOAD_CACHE && \
$WGET http://puppetlabs.com/downloads/facter/facter-${FACTER_VERSION}.tar.gz && \
tar -xzf facter-${FACTER_VERSION}.tar.gz && \
cd facter-${FACTER_VERSION} && \
ruby install.rb

# puppet
cd $DOWNLOAD_CACHE && \
$WGET http://puppetlabs.com/downloads/puppet/puppet-${PUPPET_VERSION}.tar.gz && \
tar -xzf puppet-${PUPPET_VERSION}.tar.gz && \
cd puppet-${PUPPET_VERSION} && \
ruby install.rb

# bootstrap
cd $BASEDIR && \
puppet -v bootstrap.pp
