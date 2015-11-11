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
LOCAL="local"
REMOTE="remote"
BOTH="both"

ACTION_ADD="add"
ACTION_LOG="log"
ACTION_INIT="init"
ACTION_PUSH="push"
ACTION_PULL="pull"
ACTION_HELP="help"
ACTION_EXIT="exit"
ACTION_CLEAR="clear"
ACTION_CLEAN="clean"
ACTION_MERGE="merge"
ACTION_CLONE="clone"
ACTION_RESET="reset"
ACTION_REVERT="revert"
ACTION_BRANCH="branch"
ACTION_REBASE="rebase"
ACTION_COMMIT="commit"
ACTION_CONFIG="config"
ACTION_REMOVE="remove"
ACTION_REMOTE="remote"
ACTION_REFLOG="reflog"
ACTION_STATUS="status"
ACTION_CHECKOUT="checkout"

# Variables
LOOP=1
ACTION=""
AUTHOR=""
OPTIONS=""
RESPONSE=""
FILENAME=""
AUTHOR_EMAIL=""
COMMIT_TITLE=""
COMMIT_HASH=""
COMMIT_DESCRIPTION=""
LOCAL_BRANCH_NAME=""
REMOTE_NAME=""
REMOTE_URL=""
REMOTE_BRANCH_NAME=""
CONFIG_USERNAME=""
CONFIG_USERMAIL=""
BRANCH_IN=""
BRANCH_FROM=""
REPOSITORY=""
DIRECTORY=""

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
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to add. $NORMAL"
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
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to display log. $NORMAL"
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
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to push. $NORMAL"
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
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to pull. $NORMAL"
	fi
}

# Merge : Use it to merge a branch into another
merge()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "You are actually on branch :"
		echo "-----------------------------------"
		git branch
		echo "$CYAN"
		echo "Please, enter the branch you want to merge in your current branch: $NORMAL"
		read BRANCH_FROM
		echo "$CYAN"
		echo "You're about to merge branch $BRANCH_FROM into your current branch, are you sure $NORMAL?"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			git merge $BRANCH_FROM
		else
			return 0;
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to merge. $NORMAL"
	fi
}

# Clone : Use it to clone another repository
clone()
{
	if [ -d .git ]; then
		echo "$RED"
		echo "This directory is already a git repository !"
		echo "Are you sure you want to clone an other repository here ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$NO" ]; then
			return 0;
		else
			echo "$CYAN"
			echo "Please, enter a complete repository address : $NORMAL"
			read REPOSITORY
			git clone REPOSITORY
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
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to configure. $NORMAL"
	fi
}

# Commit : Use it to commit your changes and enable versionning for theses changes
commit()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a commit title : $NORMAL"
		read COMMIT_TITLE
		echo "$CYAN"
		echo "Please, enter a commit description : $NORMAL"
		read COMMIT_DESCRIPTION
		MESSAGE=`echo "\n$COMMIT_DESCRIPTION"`
		echo "$CYAN"
		echo "Would you like to add all files to be commited ? $NORMAL"
		COMMIT_TITLE="$COMMIT_TITLE $MESSAGE";
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
			echo "\nCommit TITLE"
			echo "--------------------------------------"
			echo "$COMMIT_TITLE"
			echo "\n $COMMIT_DESCRIPTION"
			git status
		fi
		echo "$CYAN"
		echo "Would you like to push your commit on a remote branch ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			echo "$CYAN"
			echo "Please, enter a remote branch name for your commit : $NORMAL"
			read REMOTE_BRANCH_NAME
			git commit -m "$COMMIT_TITLE"
			git push origin $REMOTE_BRANCH_NAME
			echo "$GREEN"
			echo "Modification successfully commited and pushed on the remote branch $REMOTE_BRANCH_NAME ! $NORMAL"
		else
			git commit -m "$COMMIT_TITLE"
			echo "$GREEN"
			echo "Modification successfully commited ! $NORMAL"
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

# Remote : Use it to take a look on your remote configuration
remote()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Would you like to see your remote(s) repository ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ]; then
			echo "$GREEN"
			echo "Displaying repository log:"
			echo "------------------------------------------------"
			git remote -v
			echo "------------------------------------------------"
			echo "$CYAN"
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
			echo "$CYAN"
			echo "Would you like to add a new remote repository ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				echo "$CYAN"
				echo "Please, enter remote name : $NORMAL"
				read REMOTE_NAME
				echo "$CYAN"
				echo "Please, enter remote URL : $NORMAL"
				read REMOTE_URL
				echo "$CYAN"
				echo "You're about to add $REMOTE_URL as $REMOTE_NAME, are you sure ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ]; then
					git remote add $REMOTE_NAME $REMOTE_URL
					echo "$GREEN"
					echo "Remote $REMOTE_NAME successfully added ! $NORMAL"
				fi 
			else
				echo "$CYAN"
				echo "Would you like to delete a remote repository ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ]; then
					echo "$CYAN"
					echo "Please, enter remote name : $NORMAL"
					read REMOTE_NAME
					echo "$CYAN"
					echo "You're about to delete $REMOTE_NAME, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ]; then
						git remote rm $REMOTE_NAME
						echo "$GREEN"
						echo "Remote $REMOTE_NAME successfully removed ! $NORMAL"
					fi
				fi
			fi
		fi	
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to configure remote. $NORMAL"
	fi
}

# Branch : Use it to handle branch in your git repository	
branch()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Do you want to create a new branch ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			echo "$CYAN"
			echo "Please, enter a name for your branch : $NORMAL"
			read BRANCH_IN
			echo "$CYAN"
			echo "You are about to create a new branch with the same configuration of your current one, are you sure ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ];then
				git checkout -b $BRANCH_IN
			else
				return 0;
			fi
		else
			echo "$CYAN"
			echo "Do you want to delete an existing branch ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ];then
				echo "$CYAN"
				echo "What kind of deleting do you want to do : local, remote or both ? $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$BOTH" ];then
					echo "$CYAN"
					echo "Please, enter a branch name to be deleted : $NORMAL"
					read BRANCH_IN
					echo "$CYAN"
					echo "You about to delete local and remote branch named $BRANCH_IN, are you sure $NORMAL?"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git branch -d $BRANCH_IN
						git push origin :$BRANCH_IN
					else
						return 0;
					fi
				else
					if [ "$RESPONSE" = "$REMOTE" ];then
						echo "$CYAN"
						echo "Please, enter a branch name to be deleted : $NORMAL"
						read BRANCH_IN
						echo "$CYAN"
						echo "You about to delete remote branch named $BRANCH_IN, are you sure $NORMAL?"
						read RESPONSE
						if [ "$RESPONSE" = "$YES" ];then
							git push origin :$BRANCH_IN
						else
							return 0;
						fi
					else
						if [ "$RESPONSE" = "$LOCAL" ];then
							echo "$CYAN"
							echo "Please, enter a branch name to be deleted : $NORMAL"
							read BRANCH_IN
							echo "$CYAN"
							echo "You about to delete local branch named $BRANCH_IN, are you sure $NORMAL?"
							read RESPONSE
							if [ "$RESPONSE" = "$YES" ];then
								git branch -d $BRANCH_IN
							else
								return 0;
							fi
						else
							return 0;
						fi
					fi
				fi
			else
				return 0;
			fi
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to commit. $NORMAL"
	fi
}

checkout()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Do you want to change your current branch ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			echo "$CYAN"
			echo "Do you want to commit your work first ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ];then
				commit
				echo "$CYAN"
				echo "Please enter a branch name: $NORMAL"
				read BRANCH_IN
				git checkout $BRANCH_IN
			else
				echo "$CYAN"
				echo "Are you sure you want to force the change: $NORMAL"
				read RESPONSE
				if [ "$RESPONSE" = "$YES" ];then
					echo "$CYAN"
					echo "Please enter a branch name: $NORMAL"
					read BRANCH_IN
					git checkout -f $BRANCH_IN
				else
					return 0;
				fi
			fi
		else
			return 0;
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to checkout. $NORMAL"
	fi
}

revert()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Do you want to see project history first ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			git log --oneline
		fi
		echo "$CYAN"
		echo "Please, enter the commit hash you want to go back to ? $NORMAL"
		read COMMIT_HASH
		echo "$CYAN"
		echo "You are about to go back to commit N°$COMMIT_HASH, are you sure ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			git revert $COMMIT_HASH
			echo "$GREEN"
			echo "Branch successfully reverted to commit N°$COMMIT_HASH ! $NORMAL"
			echo "$CYAN"
			echo "Would you like to push reverted commit ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ];then
				push
			fi
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to revert. $NORMAL"
	fi
}

reset()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Do you want to see project history first ? $NORMAL"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			git log --oneline
		fi
		echo "$CYAN"
		echo "Do you want to reset BOTH staging area and working directory ?"
		read RESPONSE
		if [ "$RESPONSE" = "$YES" ];then
			git reset --hard
		else
			echo "$CYAN"
			echo "Do you want to reset only staging area ? $NORMAL"
			if [ "$RESPONSE" = "$YES" ];then
				git reset
			else
				echo "$CYAN"
				echo "Do you want to reset all changes since a commit ? $NORMAL"
				if [ "$RESPONSE" = "$YES" ];then
					echo "$CYAN"
					echo "Please, enter the commit hash you want to go back to ? $NORMAL"
					read COMMIT_HASH
					echo "$CYAN"
					echo "You are about to resel all commit from now to N°$COMMIT_HASH, are you sure ? $NORMAL"
					read RESPONSE
					if [ "$RESPONSE" = "$YES" ];then
						git reset --hard $COMMIT_HASH
						echo "$GREEN"
						echo "Branch successfully reverted to commit N°$COMMIT_HASH ! $NORMAL"
					fi
				fi
			fi
		fi
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to revert. $NORMAL"
	fi
}

clean()
{
	if [ -d .git ]; then
		exit
	else
		echo "$RED"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $RED command before any attempt to revert. $NORMAL"
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
	if [ "$ACTION" = "$ACTION_COMMIT" ];then
		commit
	fi
	if [ "$ACTION" = "$ACTION_CONFIG" ];then
		config
	fi
	if [ "$ACTION" = "$ACTION_REMOTE" ];then
		remote
	fi
	if [ "$ACTION" = "$ACTION_REVERT" ];then
		revert
	fi
	if [ "$ACTION" = "$ACTION_RESET" ];then
		reset
	fi
	if [ "$ACTION" = "$ACTION_BRANCH" ];then
		branch
	fi
	if [ "$ACTION" = "$ACTION_CHECKOUT" ];then
		checkout
	fi
	if [ "$ACTION" = "$ACTION_HELP" ];then
		gpmhelp
	fi
	if [ "$ACTION" = "$ACTION_CLEAR" ];then
		clear
	fi
	if [ "$ACTION" = "$ACTION_EXIT" ];then
		LOOP=0
	fi
done
