#!/bin/bash

# Output colors

VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ROSE="\\033[1;35m"
BLEU="\\033[1;34m"
BLANC="\\033[0;02m"
BLANCLAIR="\\033[1;08m"
JAUNE="\\033[1;33m"
CYAN="\\033[1;36m"

# Value

NO="no"
YES="yes"

ACTION_ADD="add"
ACTION_LOG="log"
ACTION_TAG="tag"
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

# Functions

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
			echo "$VERT"
			echo "All files successfully added ! $NORMAL"
		else
			echo "$CYAN"
		fi
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi

}

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
			echo "$VERT"
			echo "Logs successfully saved in $FILENAME ! $NORMAL"
		fi
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

tag()
{
	echo "Function tag"
}

init()
{
	if [ -d .git ]; then
		echo "$ROUGE"
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

			echo "$VERT"
			echo "Repository successfully initialized ! $NORMAL"
		fi
	fi
}

push()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a remote branch to push code on : $NORMAL"
		read REMOTE_BRANCH_NAME
		git push origin "$REMOTE_BRANCH_NAME"
		echo "$VERT"
		echo "Content successfully pushed on branch $REMOTE_BRANCH_NAME ! $NORMAL"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

pull()
{
	if [ -d .git ]; then
		echo "$CYAN"
		echo "Please, enter a remote branch to pull code from : $NORMAL"
		read REMOTE_BRANCH_NAME
		git pull origin "$REMOTE_BRANCH_NAME"
		echo "$VERT"
		echo "Content successfully pulled from branch $REMOTE_BRANCH_NAME ! $NORMAL"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

fetch()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

merge()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

clone()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

reset()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

rebase()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

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
			echo "$VERT"
			echo "Global configuration successfully saved ! $NORMAL"
		else
			echo "$CYAN"
			echo "Would you like to make this configuration a system configuration ? $NORMAL"
			read RESPONSE
			if [ "$RESPONSE" = "$YES" ]; then
				git config --system user.name "$CONFIG_USERNAME"
				git config --system user.email "$CONFIG_USERMAIL"
				echo "$VERT"
				echo "System configuration successfully saved ! $NORMAL"
			else
				git config user.name "$CONFIG_USERNAME"
				git config user.email "$CONFIG_USERMAIL"
				echo "$VERT"
				echo "Local configuration successfully saved ! $NORMAL"
			fi
		fi
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

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

			echo "$VERT"
			echo "Modification successfully commited and pushed on the remote branch $REMOTE_BRANCH_NAME ! $NORMAL"
		else
			git commit -m "$COMMIT_DESCRIPTION"
			echo "$VERT"
			echo "Modification successfully commited ! $NORMAL"
		fi
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

remove()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

remote()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

rename()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}
	
create()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}

delete()
{
	if [ -d .git ]; then
		echo "$CYAN"
	else
		echo "$ROUGE"
		echo "This directory isn't a git repository."
		echo "Please, create a git repository with the $NORMAL init $ROUGE command before any attempt to commit. $NORMAL"
	fi
}


####### Opening Message ###########

echo "$CYAN"
echo "Welcome in the git project manager ! Who are you ? $NORMAL"
read AUTHOR

while [ $LOOP -gt 0 ]; do
	echo "$CYAN"
	echo "Hi, $AUTHOR ! What do you want to do ? $NORMAL"
	read ACTION

	if [ "$ACTION" = "$ACTION_ADD" ];then
		add
	fi
	if [ "$ACTION" = "$ACTION_LOG" ];then
		log
	fi
	if [ "$ACTION" = "$ACTION_TAG" ];then
		tag
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
	if [ "$ACTION" = "$ACTION_COMMIT" ];then
		commit
	fi
	if [ "$ACTION" = "$ACTION_CONFIG" ];then
		config
	fi
	LOOP=0
done
