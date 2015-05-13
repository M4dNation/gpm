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

# Answer

YES="yes"
NO="no"

# All actions to perform

ACTION=""
RESPONSE=""
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


# Branch variables

LOCAL_BRANCH_NAME=""
DISTANT_BRANCH_NAME=""

# User information

AUTHOR=""
AUTHOR_EMAIL=""
AUTHOR_NAME_AXEL="Axel Vaindal"

# Email

AUTHOR_EMAIL_AXEL="pro.axelvaindal@"

# Distant information needed
NAME_AXEL="Axel"

####### Opening Message ###########

echo "$ROUGE\nWelcome in the git project manager ! Who are you ? $NORMAL"
read AUTHOR

echo "$ROUGE"
echo "Hi, $AUTHOR ! What do you want to do ? $NORMAL"
read ACTION

if [ "$ACTION" = "$ACTION_LOG" ];then
	echo "$CYAN\nDisplaying repository log:"
	echo "------------------------------------------"
	git log
fi