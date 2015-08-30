#!/bin/bash

# Output colors
NORMAL="\\033[0;39m"
RED="\\033[1;31m"
GREEN="\\033[1;32m"
YELLOW="\\033[1;33m"
BLUE="\\033[1;34m"
PINK="\\033[1;35m"
CYAN="\\033[1;36m"
WHITE="\\033[1;38m"
GREY="\\033[1;30m"

# Value
YES="yes"
ACTION_ADD="add"
ACTION_LOG="log"
ACTION_INIT="init"
ACTION_PUSH="push"
ACTION_PULL="pull"
ACTION_FETCH="fetch"
ACTION_MERGE="merge"
ACTION_CLONE="clone"
ACTION_RESET="reset"
ACTION_REBASE="rebase"
ACTION_COMMIT="commit"
ACTION_CONFIG="config"
ACTION_REMOVE="remove"
ACTION_REMOTE="remote"
ACTION_RENAME="rename"
ACTION_CREATE_BRANCH="create"
ACTION_DELETE_BRANCH="delete"

# Variables
LOOP=1
ACTION=""
AUTHOR=""
OPTIONS=""
RESPONSE=""
FILENAME=""
AUTHOR_EMAIL=""
COMMIT_DESCRIPTION=""
LOCAL_BRANCH_NAME=""
REMOTE_BRANCH_NAME=""
CONFIG_USERNAME=""
CONFIG_USERMAIL=""
BRANCH_IN=""
BRANCH_FROM=""
REPOSITORY=""

# Functionnalities


# Add : Use it to track file for versionning
add()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "You are about to add files to be commited. Would you like to see current branch' status first ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			git status
			echo "$CYAN"
			echo "Would you like more detail about changes before adding files to be commited ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				git diff
			fi
		fi
		echo "$CYAN"
		echo "Would you like to add every file of the directory to be tracked ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			git add .
			echo "$CYAN"
			echo "Displaying tracked file:"
			echo "--------------------------------------"
			git status
			echo "$GREEN"
			echo "All files successfully added ! $NORMAL"
		else
			FILENAME="FILENAME"
			while [ "$FILENAME" != "" ]; do
				echo "$CYAN"
				echo "Please, enter the name of the file or directory you wish to add (no name to stop) : $NORMAL"
				read FILENAME
				if [ "$FILENAME" != "" ]; then
					if [ -d "$FILENAME" ]; then
						git add "$FILENAME"
						echo "$GREEN"
						echo "Directory $FILENAME successfully added ! $NORMAL"
					else
						if [ -e "$FILENAME" ]; then
							git add "$FILENAME"
							echo "$GREEN"
							echo "File $FILENAME successfully added ! $NORMAL"
						else
							echo "$RED"
							echo "Unable to add $FILENAME, file or directory not found !"
						fi
					fi
					echo "$CYAN"
					echo "Would you like to see current branch' status now ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ]; then
						echo "$CYAN"
						echo "Displaying tracked file:"
						echo "--------------------------------------"
						git status
					fi
				fi
			done
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi

}

# Log : Use it to display any commit log about your current branch
log()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Displaying repository log:"
		echo "------------------------------------------"
		git log
		echo "$CYAN"
		echo "------------------------------------------"
		echo "Do you want to save these logs in a file ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			echo "$CYAN"
			echo "Please, enter filename : $NORMAL"
			read FILENAME
			echo "$CYAN"
			echo "Erase content of $FILENAME ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ];then
				echo "$CYAN"
				echo "You are about to save git logs in $FILENAME deleting all its content, are you sure ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ];then
					git log > $FILENAME
				fi
			else
				echo "$CYAN"
				echo "You are about to add git logs to $FILENAME, are you sure ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ];then
					git log >> $FILENAME
				fi
			fi
			echo "$GREEN"
			echo "Logs successfully saved in $FILENAME ! $NORMAL"
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Init : Use it to initialize a new git repositiory
init()
{
	if [ -d .git ]; then
		echo "$RED"
		echo "This directory is already a git repository. $NORMAL"
	else
		echo "$CYAN"
		echo "Would you like to create a git repository here ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			echo "$CYAN"
			echo "You can add here your options to customize your repository : $NORMAL"
			read OPTIONS
			git init $OPTIONS

			echo "$GREEN"
			echo "Repository successfully initialized ! $NORMAL"
		fi
	fi
}

# Push : Use it to push local versionning on a remote branch
push()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a remote branch to push code on : $NORMAL"
		read REMOTE_BRANCH_NAME
		git push origin "$REMOTE_BRANCH_NAME"
		echo "$GREEN"
		echo "Content successfully pushed on branch $REMOTE_BRANCH_NAME ! $NORMAL"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Pull : Use it to pull remote versionning on a local branch
pull()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a remote branch to pull code from : $NORMAL"
		read REMOTE_BRANCH_NAME
		git pull origin "$REMOTE_BRANCH_NAME"
		echo "$GREEN"
		echo "Content successfully pulled from branch $REMOTE_BRANCH_NAME ! $NORMAL"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Merge : Use it to merge a branch into another
merge()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter the branch you want to merge in : $NORMAL"
		read BRANCH_IN
		git checkout $BRANCH_IN 2> tmp.txt
		if [ $? -ne 0 ]; then
			echo "An error occured ! Please, fix it."
			echo "------------------------------------"
			cat tmp.txt
			rm tmp.txt
		else
			echo "$CYAN"
			echo "Please, enter the branch you want to merge : $NORMAL"
			read BRANCH_FROM
			echo "You're about to merge branch $BRANCH_FROM into $BRANCH_IN, are you sure ?"
			read RESPONSE
			if [ "$RESPONSE" = "$NO" ]; then
				return 0;
			else
				git merge $BRANCH_FROM
			fi
			rm tmp.txt > /dev/null
		fi

	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Clone : Use it to clone another repository
clone()
{
	if [ -d .git ]; then
		echo "$RED"
		echo "This directory is already a git repository !"
		echo "Are you sure you want to clone an other repository here ?"
		read RESPONSE
		if [ "$RESPONSE" = "$NO" ]; then
			return 0;
		fi
	else
		echo "$CYAN"
		echo "Please, enter repository's URL :"
		read REPOSITORY
		echo "Please, enter a directory name (default is current one):"
		read DIRECTORY
		git clone REPOSITORY DIRECTORY
	fi

}

# Reset : 
reset()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Rebase : 
rebase()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Config : Use it to configure your repository
config()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Full Git configuration"
		echo "-----------------------"
		echo "Please, enter username : $NORMAL"
		read CONFIG_USERNAME
		echo "$CYAN"
		echo "Please, enter user email : $NORMAL"
		read CONFIG_USERMAIL
		echo "$CYAN"
		echo "Would you like to make this configuration global for your git environment ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			git config --global user.name "$CONFIG_USERNAME"
			git config --global user.email "$CONFIG_USERMAIL"
			echo "$GREEN"
			echo "Global configuration successfully saved ! $NORMAL"
		else
			echo "$CYAN"
			echo "Would you like to make this configuration a system configuration ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				git config --system user.name "$CONFIG_USERNAME"
				git config --system user.email "$CONFIG_USERMAIL"
				echo "$GREEN"
				echo "System configuration successfully saved ! $NORMAL"
			else
				git config user.name "$CONFIG_USERNAME"
				git config user.email "$CONFIG_USERMAIL"
				echo "$GREEN"
				echo "Local configuration successfully saved ! $NORMAL"
			fi
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Commit : Use it to commit your changes and enable versionning for theses changes
commit()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a commit description : $NORMAL"
		read COMMIT_DESCRIPTION
		echo "$CYAN"
		echo "Would you like to add all files to be commited ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			git add .
		else
			echo "$CYAN"
			echo "Would you like to add files to be commited ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				add
			fi
		fi
		echo "$CYAN"
		echo "You are about to make a commit on your current branch."
		echo "Would you like to see all information about the commit ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			echo "\nCommit description"
			echo "--------------------------------------"
			echo "$COMMIT_DESCRIPTION"
			git status
		fi
		echo "$CYAN"
		echo "Would you like to push your commit on a remote branch ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			echo "$CYAN"
			echo "Please, enter a remote branch name for your commit : $NORMAL"
			read REMOTE_BRANCH_NAME
			git commit -m "$COMMIT_DESCRIPTION"
			git push origin $REMOTE_BRANCH_NAME

			echo "$GREEN"
			echo "Modification successfully commited and pushed on the remote branch $REMOTE_BRANCH_NAME ! $NORMAL"
		else
			git commit -m "$COMMIT_DESCRIPTION"
			echo "$GREEN"
			echo "Modification successfully commited ! $NORMAL"
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Remove : 
remove()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Remote : 
remote()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Would you like to see URL(s) of your remote(s) repository ?"
		read RESPONSE
		echo "Displaying repository log:"
		echo "------------------------------------------"
		if [ "$RESPONSE" = "$YES" ]; then
			git remote -v
			echo "$CYAN"
			echo "------------------------------------------"
			echo "Do you want to save this in a file ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				echo "$CYAN"
				echo "Please, enter filename : $NORMAL"
				read FILENAME
				echo "$CYAN"
				echo "Erase content of $FILENAME ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ];then
					echo "$CYAN"
					echo "You are about to save remote(s) informations in $FILENAME deleting all its content, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git remote -v > $FILENAME
					fi
				else
					echo "$CYAN"
					echo "You are about to add remote(s) informations to $FILENAME, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git remote -v >> $FILENAME
					fi
				fi
				echo "$GREEN"
				echo "Remote(s) informations successfully saved in $FILENAME ! $NORMAL"
			fi
		else
			git remote
			echo "$CYAN"
			echo "------------------------------------------"
			echo "Do you want to save this in a file ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				echo "$CYAN"
				echo "Please, enter filename : $NORMAL"
				read FILENAME
				echo "$CYAN"
				echo "Erase content of $FILENAME ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ];then
					echo "$CYAN"
					echo "You are about to save remote(s) informations in $FILENAME deleting all its content, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git remote > $FILENAME
					fi
				else
					echo "$CYAN"
					echo "You are about to add remote(s) informations to $FILENAME, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git remote >> $FILENAME
					fi
				fi
				echo "$GREEN"
				echo "Remote(s) informations successfully saved in $FILENAME ! $NORMAL"
			fi
		fi
		
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

	
create()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

delete()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}


####### Main ###########

while [ $LOOP -gt 0 ]; do
	echo "$CYAN"
	echo "Welcome in the git project manager ! What do you want to do ? $NORMAL"
	read ACTION

	if [ "$ACTION" = "$ACTION_ADD" ];then
		add
	fi
	if [ "$ACTION" = "$ACTION_LOG" ];then
		log
	fi
	if [ "$ACTION" = "$ACTION_INIT" ];then
		init
	fi
	if [ "$ACTION" = "$ACTION_PUSH" ];then
		push
	fi
	if [ "$ACTION" = "$ACTION_PULL" ];then
		pull
	fi
	if [ "$ACTION" = "$ACTION_MERGE" ];then
		merge
	fi
	if [ "$ACTION" = "$ACTION_CLONE" ];then
		clone
	fi
	if [ "$ACTION" = "$ACTION_RESET" ];then
		reset
	fi
	if [ "$ACTION" = "$ACTION_REBASE" ];then
		rebase
	fi
	if [ "$ACTION" = "$ACTION_COMMIT" ];then
		commit
	fi
	if [ "$ACTION" = "$ACTION_CONFIG" ];then
		config
	fi
	if [ "$ACTION" = "$ACTION_REMOVE" ];then
		remove
	fi
	if [ "$ACTION" = "$ACTION_REMOTE" ];then
		remote
	fi

	LOOP=0
done
