#!/bin/bash
# git.sh
#
#
#
#################################################################################


# Variables
#################################################################################

LOOP=1

# Functions
#################################################################################

##
# init
# This function is used in order to initialize a new git repository.
##
init()
{
	if [ -d .git ]
	then
		echo -e "$COLOR_FAILURE"
		echo "This directory is already a git repository."
		echo -e "$COLOR_NORMAL"
	else
		echo -e "$COLOR_INFO"
		echo "Would you like to create a git repository here ?"
		echo -e "$COLOR_NORMAL"
		if confirm
		then
			echo -e "$COLOR_INFO"
			echo -e "Would you like to make this repository a bare repository ?"
			echo -e "$COLOR_NORMAL"
			if confirm
			then
				if isFalse $INIT_QUIET
				then
					echo -e "$COLOR_SUCCESS"
					git init --bare
					echo -e "$COLOR_NORMAL"
				else
					git init --bare --quiet
				fi
			else
				if isFalse $INIT_QUIET
				then
					echo -e "$COLOR_SUCCESS"
					git init
					echo -e "$COLOR_NORMAL"
				else
					git init --quiet
				fi
			fi
		fi
	fi
}

##
# config
# This function is used in order to config a git repository.
##
config()
{
	if [ -d .git ] 
	then
		echo -e "$COLOR_NORMAL"
		if isGlobalConfiguration $CONFIG_SCOPE
		then
			git config --global user.name "$CONFIG_USERNAME"
			git config --global user.email "$CONFIG_USERMAIL"
			echo -e "$COLOR_SUCCESS"
			echo -e "Global configuration successfully saved ! $COLOR_NORMAL"
		else
			if isSystemConfiguration $CONFIG_SCOPE
			then
				git config --system user.name "$CONFIG_USERNAME"
				git config --system user.email "$CONFIG_USERMAIL"
				echo -e "$COLOR_SUCCESS"
				echo -e "System configuration successfully saved ! $COLOR_NORMAL"
			else
				git config user.name "$CONFIG_USERNAME"
				git config user.email "$CONFIG_USERMAIL"
				echo -e "$COLOR_SUCCESS"
				echo -e "Local configuration successfully saved ! $COLOR_NORMAL"
			fi
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to configure."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# clone
# This function is used in order to clone another git repository.
##
clone()
{
	if [ -d .git ]; then
		echo -e "$COLOR_FAILURE"
		echo "This directory is already a git repository !"
		echo -e "Are you sure you want to clone an other repository here ? $COLOR_NORMAL"
		if confirm 
		then
			echo -e "$COLOR_INFO"
			echo -e "Please, enter a complete repository address : $COLOR_NORMAL"
			read REPOSITORY
			if isFalse $CLONE_QUIET
			then
				git clone $REPOSITORY
			else
				git clone --quiet $REPOSITORY
			fi
		else
			return 0;
		fi
	else
		echo -e "$COLOR_INFO"
		echo -e "Please, enter repository's URL : $COLOR_NORMAL"
		read REPOSITORY
		echo -e "Please, enter a directory name (default is current one): $COLOR_NORMAL"
		read DIRECTORY
		if isFalse $CLONE_QUIET
		then
			git clone $REPOSITORY $DIRECTORY
		else
			git clone --quiet $REPOSITORY $DIRECTORY
		fi
	fi
}

##
# status
# This function is used in order to display current status of the repository.
##
status()
{
	OPTIONS=""
	if [ -d .git ]
	then
		if isTrue $STATUS_UNTRACKED
		then
		OPTIONS="$OPTIONS --untracked-files"
		fi
		if isTrue $STATUS_IGNORED
		then
			OPTIONS="$OPTIONS --ignored"
		fi
		if isTrue $STATUS_SHORT
		then
			OPTIONS="$OPTIONS --short"
		fi
		if isTrue $STATUS_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		git status $OPTIONS
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to get status."
		echo -e "$COLOR_NORMAL"
	fi
}

diff()
{
	OPTIONS=""
	if [ -d .git ]
	then
		if isTrue $DIFF_QUIET
		then
		OPTIONS="$OPTIONS --quiet"
		fi
		if isTrue $DIFF_RAW
		then
			OPTIONS="$OPTIONS --raw"
		fi
		if isTrue $DIFF_STAT
		then
			OPTIONS="$OPTIONS --stat"
		fi
		if isTrue $DIFF_NUMSTAT
		then
			OPTIONS="$OPTIONS --numstat"
		fi
		if isTrue $DIFF_SHORTSTAT
		then
			OPTIONS="$OPTIONS --shortstat"
		fi
		if isTrue $DIFF_DIRSTAT
		then
			OPTIONS="$OPTIONS --dirstat"
		fi
		if isTrue $DIFF_NAMEONLY
		then
			OPTIONS="$OPTIONS --name-only"
		fi
		if isTrue $DIFF_NAMESTATUS
		then
			OPTIONS="$OPTIONS --name-status"
		fi
		if isTrue $DIFF_NOCOLOR
		then
			OPTIONS="$OPTIONS --no-color"
		fi
		if isAlgorithmMinimal $DIFF_ALGORITHM
		then
			OPTIONS="$OPTIONS --minimal"
		fi
		if isAlgorithmPatience $DIFF_ALGORITHM
		then
			OPTIONS="$OPTIONS --patience"
		fi
		if isAlgorithmHistogram $DIFF_ALGORITHM
		then
			OPTIONS="$OPTIONS --histogram"
		fi
		if isTrue $DIFF_PATCH
		then
			OPTIONS="$OPTIONS --patch"
		fi
		git diff $OPTIONS
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to get diff."
		echo -e "$COLOR_NORMAL"
	fi
}


# Main Loop
#################################################################################

source ../gpm/.gitconfig.cfg
while [ $LOOP -gt 0 ]; do
	echo -e "$COLOR_INFO"
	echo -e "Welcome in the git project manager ! What do you want to do ? $COLOR_NORMAL"
	read ACTION
	if isActionInit $ACTION
	then
		init
	fi
	if isActionConfig $ACTION
	then
		config
	fi
	if isActionClone $ACTION
	then
		clone
	fi
	if isActionStatus $ACTION
	then
		status
	fi
	if isActionDiff $ACTION
	then
		diff
	fi
done