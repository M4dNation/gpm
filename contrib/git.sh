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
ACTION_REMOVE="remove"
ACTION_REMOTE="remote"
ACTION_RENAME="rename"
ACTION_CREATE_BRANCH="create"
ACTION_DELETE_BRANCH="delete"

NAME_AXEL="Axel"
AUTHOR_NAME_AXEL="Axel Vaindal"
AUTHOR_EMAIL_AXEL="pro.axelvaindal@gmail.com"

# Variables
LOOP=1
ACTION=""
AUTHOR=""
RESPONSE=""
FILENAME=""
AUTHOR_EMAIL=""
LOCAL_BRANCH_NAME=""
DISTANT_BRANCH_NAME=""

# User information


####### Opening Message ###########

echo "$CYAN"
echo "Welcome in the git project manager ! Who are you ? $NORMAL"
read AUTHOR

while [ $LOOP -gt 0 ]; do
	echo "$CYAN"
	echo "Hi, $AUTHOR ! What do you want to do ? $NORMAL"
	read ACTION

	################## LOG ACTION ###################################
	if [ "$ACTION" = "$ACTION_LOG" ];then
		log
	fi
	################## LOG ACTION ###################################
	LOOP=0
done

function log 
{
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
	fi
}