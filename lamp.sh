#!/bin/bash

reading="false"
a_install="false"
m_install="false"
p_install="false"

#sudo apt-get update

for val in $@
do
	if [ "$val" = "-h" -o "$val" = "--help" ]
	then
		echo -e "lamp.sh [-option] <program>\n\noptions:\n-i <program> = installations\n-h/--help = show help\n\nprograms:\napache - install Apache2\nmysql - install MariaDB\nphp - install PHP\nall - installs the lamp stack entirely"
		break
	fi

	if [ "$val" = "-i" ]
	then
		reading="true"

		continue
	fi
	
	if [ "$reading" = "true" ]
	then
		if [ "$val" = "all" ]
		then
			sudo apt-get update

			echo "installing apache2, mysql, mariadb, php..."
			sudo apt-get install apache2 mariadb-server php libapache2-mod-php php-mysql
			a_install="true"
			m_install="true"
			p_install="true"
			break	
		fi

		if [ "$val" = "apache" ]
		then
			sudo apt-get update
			echo "installing apache..."
			sudo apt-get install apache2
			a_install="true";
			continue
		fi

		if [ "$val" = "mysql" ]
		then
			sudo apt-get update
			echo "installing mysql..."
			sudo apt-get install mysql-server
			sudo apt-get install mariadb-server
			m_install="true";
			continue
		fi

		if [ "$val" = "php" ]
		then
			sudo apt-get update
			echo "installing php"
			sudo apt install php libapache2-mod-php php-mysql
			p_install="true"
			continue
		else
			echo "no program was chosen to install"
		fi
	fi
done

reading="false"

for val in $@
do
	if [ "$val" = "-u" ]
	then
		reading="true"
		continue
	fi
	
	if [ "$reading" = "true" ]
	then
		if [ "$val" = "apache" ]
		then
			if [ "$a_install" = "true" ]
			then
				echo "can't install and uninstall $val at the same time"
				a_install="false"
			else
				echo "unstalling apache"
				sudo apt-get --purge autoremove apache2
				continue
			fi
		fi

		if [ "$val" = "mysql" ]
		then
			if [ "$m_install" = "true" ]
			then
				echo "can't install and uninstall $val at the same time"
				m_install="false"
			else
				echo "unstalling mysql"
				sudo apt-get --purge autoremove mariadb-server
				continue
			fi
		fi

		if [ "$val" = "php" ]
		then
			if [ "$p_install" = "true" ]
			then
				echo "can't install and uninstall $val at the same time"
				p_install="false"
			else
				echo "unstalling php"
				sudo apt-get --purge autoremove php php-mysql libapache2-mod-php
				continue
			fi
		fi
	fi
done
