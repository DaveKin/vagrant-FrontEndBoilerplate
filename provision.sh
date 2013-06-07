#!/usr/bin/env bash
printf "Running apt-get update....\n\n"
apt-get update
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant/www /var/www

# PACKAGE INSTALLATION
#
# Build a bash array to pass all of the packages we want to install to
# a single apt-get command. This avoids having to do all the leg work
# each time a package is set to install. It also allows us to easily comment
# out or add single packages.

# ensure the latest nodejs build is used
sudo apt-get update
sudo apt-get install python-software-properties python g++ make --force-yes -y
sudo add-apt-repository ppa:chris-lea/node.js 
sudo apt-get update

apt_package_list=(
	# Imagemagick
	# imagemagick

	# PHP5
	#
	# Our base packages for php5. As long as php5-fpm and php5-cli are
	# installed, there is no need to install the general php5 package, which
	# can sometimes install apache as a requirement.
	php5-fpm
	php5-cli
	
	# Common and dev packages for php
	php5-common
	php5-dev

	# Extra modules that we find useful
	php5-imap
	php5-memcache
	php5-imagick
	php5-xdebug
	php5-mcrypt
	# php5-mysql
	php5-curl
	php-pear
	php5-gd
	php-apc

	# nginx
	#nginx

	# mysql
	# mysql-server

	# MISC Packages
	# subversion
	ack-grep
	git-core
	unzip
	ngrep
	curl
	#make
	vim

	#node
	nodejs

	# memcached
	memcached

	# Install dos2unix, which allows conversion of DOS style line endings to
	# something we'll have less trouble with in linux.
	dos2unix
)

printf "Install all apt-get packages...\n"
apt-get install --force-yes -y ${apt_package_list[@]}

# Clean up apt caches
apt-get clean