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
		if isGlobalConfiguration
		then
			git config --global user.name "$CONFIG_USERNAME"
			git config --global user.email "$CONFIG_USERMAIL"
			echo -e "$COLOR_SUCCESS"
			echo -e "Global configuration successfully saved ! $COLOR_NORMAL"
		else
			if isSystemConfiguration
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

##
# diff
# This function is used in order to display current differences of the repository.
##
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
		if isAlgorithmMinimal
		then
			OPTIONS="$OPTIONS --minimal"
		fi
		if isAlgorithmPatience
		then
			OPTIONS="$OPTIONS --patience"
		fi
		if isAlgorithmHistogram
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

##
# add
# This function is used in order to add files to the repository index.
##
add()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $ADD_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $ADD_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		if isTrue $ADD_DRY
		then
			OPTIONS="$OPTIONS --dry-run"
		fi
		if isTrue $ADD_IGNORE_ERRORS
		then
			OPTIONS="$OPTIONS --ignore-errors"
		fi
		echo -e "$COLOR_INFO"
		echo -e "You are about to add files to be commited. Would you like to see current branch' status first ? $COLOR_NORMAL"
		if confirm 
		then
			status
			echo -e "$COLOR_INFO"
			echo -e "Would you like more detail about changes before adding files to be commited ? $NORMAL"
			if confirm 
			then
				diff
			fi
		fi
		if isTrue $ADD_ALL 
		then
			git add $OPTIONS --all 
			echo -e "$COLOR_INFO"
			echo "Displaying tracked file:"
			echo -e "-------------------------------------- $COLOR_NORMAL"
			status
			echo -e "$COLOR_SUCCESS"
			echo -e "All files successfully added ! $COLOR_NORMAL"
		else
			FILENAME="FILENAME"
			while [ "$FILENAME" != "" ]; 
			do
				echo -e "$COLOR_INFO"
				echo -e "Please, enter the name of the file or directory you wish to add (no name to stop) : $NORMAL"
				read FILENAME
				if [ "$FILENAME" != "" ]
				then
					if [ -d "$FILENAME" ]
					then
						git add $OPTIONS "$FILENAME"
						echo -e "$COLOR_SUCCESS"
						echo -e "Directory $FILENAME successfully added ! $NORMAL"
					else
						if [ -e "$FILENAME" ]
						then
							git add "$FILENAME"
							echo -e "$COLOR_SUCCESS"
							echo -e "File $FILENAME successfully added ! $NORMAL"
						else
							echo -e "$COLOR_FAILURE"
							echo "Unable to add $FILENAME, file or directory not found !"
						fi
					fi
					echo -e "$COLOR_INFO"
					echo -e "Would you like to see current branch' status now ? $NORMAL"
					if confirm 
					then
						echo -e "$COLOR_INFO"
						echo "Displaying tracked file:"
						echo "--------------------------------------"
						status
					fi
				fi
			done
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to add."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# commit
# This function is used in order to commit changes and enable versionning for theses changes
##
commit()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $COMMIT_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		if isTrue $COMMIT_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		echo -e "$COLOR_INFO"
		echo -e "Please, enter a commit title : $COLOR_NORMAL"
		read COMMIT_TITLE
		echo -e "$COLOR_INFO"
		echo -e "Please, enter a commit description : $COLOR_NORMAL"
		read COMMIT_DESCRIPTION
		MESSAGE=`echo -e "\n$COMMIT_DESCRIPTION"`
		COMMIT_TITLE="$COMMIT_TITLE $MESSAGE";
		add
		echo -e "$COLOR_INFO"
		echo "You are about to make a commit on your current branch."
		echo -e "Would you like to see all information about the commit ? $COLOR_NORMAL"
		if confirm 
		then
			echo -e "\nCommit Informations"
			echo "--------------------------------------"
			echo "$COMMIT_TITLE"
			echo -e "\n $COMMIT_DESCRIPTION"
			status
		fi
		echo -e "$COLOR_INFO"
		echo -e "Would you like to push your commit on a remote branch ? $COLOR_NORMAL"
		if confirm 
		then
			git commit $OPTIONS -m "$COMMIT_TITLE"
			echo -e "$COLOR_SUCCESS"
			echo -e "Modification successfully commited."
			echo -e "$COLOR_NORMAL"
			push
		else
			git commit $OPTIONS -m "$COMMIT_TITLE"
			echo -e "$COLOR_SUCCESS"
			echo -e "Modification successfully commited ! $COLOR_NORMAL"
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to commit."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# push
# This function is used in order to push local versionning on a remote branch
##
push()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $PUSH_ALL
		then
			OPTIONS="$OPTIONS --all"
		fi
		if isTrue $PUSH_DRY
		then
			OPTIONS="$OPTIONS --dry-run"
		fi
		if isTrue $PUSH_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $PUSH_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		if isTrue $PUSH_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		if isTrue $PUSH_IPV4
		then
			OPTIONS="$OPTIONS --ipv4"
		fi
		if isTrue $PUSH_IPV6
		then
			OPTIONS="$OPTIONS --ipv6"
		fi
		echo -e "$COLOR_INFO"
		echo -e "Please, enter a remote branch to push code on : $COLOR_NORMAL"
		read REMOTE_BRANCH_NAME
		git push $OPTIONS origin $REMOTE_BRANCH_NAME
		echo -e "$COLOR_SUCCESS"
		echo -e "Content successfully pushed on branch $REMOTE_BRANCH_NAME ! $COLOR_NORMAL"
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to push."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# pull
# This function is used in order to pull remote versionning on a local branch
##
pull()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $PULL_ALL
		then
			OPTIONS="$OPTIONS --all"
		fi
		if isTrue $PULL_STAT
		then
			OPTIONS="$OPTIONS --stat"
		fi
		if isTrue $PULL_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $PULL_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		if isTrue $PULL_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		if isTrue $PULL_IPV4
		then
			OPTIONS="$OPTIONS --ipv4"
		fi
		if isTrue $PULL_IPV6
		then
			OPTIONS="$OPTIONS --ipv6"
		fi
		echo -e "$COLOR_INFO"
		echo -e "Please, enter a remote branch to pull code from : $COLOR_NORMAL"
		read REMOTE_BRANCH_NAME
		git pull $OPTIONS origin "$REMOTE_BRANCH_NAME"
		echo -e "$COLOR_SUCCESS"
		echo -e "Content successfully pulled from branch $REMOTE_BRANCH_NAME ! $COLOR_NORMAL"
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to pull."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# reset
# This function is used in order to reset local versionning 
##
reset()
{
	if [ -d .git ]
	then
		echo -e "$COLOR_INFO"
		echo -e "Do you want to see project history first ? $COLOR_NORMAL"
		if confirm
		then
			log
		fi
		echo -e "$COLOR_INFO"
		echo -e "Do you want to reset last commit ? $COLOR_NORMAL"
		if confirm
		then
			git reset $RESET_MODE
		else
			echo -e "$COLOR_INFO"
			echo -e "Do you want to reset all changes since a commit ? $COLOR_NORMAL"
			if confirm 
			then
				echo -e "$COLOR_INFO"
				echo -e "Please, enter the commit hash you want to go back to ? $COLOR_NORMAL"
				read COMMIT_HASH
				echo -e "$COLOR_INFO"
				echo -e "You are about to resel all commit from now to N°$COMMIT_HASH, are you sure ? $COLOR_NORMAL"
				if confirm
				then
					git reset $RESET_MODE $COMMIT_HASH
					echo -e "$COLOR_SUCCESS"
					echo -e "Branch is now at commit N°$COMMIT_HASH ! $COLOR_NORMAL"
					echo -e "$COLOR_INFO"
					echo -e "Would you like to clean your current branch now ? $COLOR_NORMAL"
					if confirm
					then
						clean
					fi
					echo -e "$COLOR_INFO"
					echo -e "Would you like to push reset commit ? $NORMAL"
					if confirm
					then
						push
					fi
				fi
			fi
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to reset."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# log
# This function is used in order to show local versionning history
##
log()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $LOG_SOURCE
		then
			OPTIONS="$OPTIONS --source"
		fi
		if isFormatOneline
		then
			OPTIONS="$OPTIONS --format=oneline"
		fi
		if isFormatShort
		then
			OPTIONS="$OPTIONS --format=short"
		fi
		if isFormatMedium
		then
			OPTIONS="$OPTIONS --format=medium"
		fi
		if isFormatFull
		then
			OPTIONS="$OPTIONS --format=full"
		fi
		if isFormatFuller
		then
			OPTIONS="$OPTIONS --format=fuller"
		fi
		if isFormatEmail
		then
			OPTIONS="$OPTIONS --format=email"
		fi
		if isFormatRaw
		then
			OPTIONS="$OPTIONS --format=raw"
		fi
		echo -e "$COLOR_INFO"
		echo "Displaying repository log:"
		echo "------------------------------------------"
		git log $OPTIONS
		echo -e "$COLOR_INFO"
		echo "------------------------------------------"
		echo -e "Do you want to save these logs in a file ? $COLOR_NORMAL"
		if confirm
		then
			echo -e "$COLOR_INFO"
			echo -e "Please, enter filename : $COLOR_NORMAL"
			read FILENAME
			echo -e "$COLOR_INFO"
			echo -e "Erase content of $FILENAME ? $COLOR_NORMAL"
			if confirm
			then
				echo -e "$COLOR_INFO"
				echo -e "You are about to save git logs in $FILENAME deleting all its content, are you sure ? $COLOR_NORMAL"
				if confirm
				then
					git log $OPTIONS > $FILENAME
				fi
			else
				echo -e "$COLOR_INFO"
				echo -e "You are about to add git logs to $FILENAME, are you sure ? $COLOR_NORMAL"
				if confirm 
				then
					git log $OPTIONS >> $FILENAME
				fi
			fi
			echo -e "$COLOR_SUCCESS"
			echo -e "Logs successfully saved in $FILENAME ! $COLOR_NORMAL"
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to reset."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# clean
# This function is used in order to clean local repository
##
clean()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $CLEAN_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $CLEAN_DRY
		then
			OPTIONS="$OPTIONS --dry-run"
		fi
		if isTrue $CLEAN_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		if isTrue $CLEAN_DIR
		then
			OPTIONS="$OPTIONS -d"
		fi
		if isTrue $CLEAN_UNTRACKED
		then
			OPTIONS="$OPTIONS -x"
		fi
		git clean $OPTIONS
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to clean."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# remove
# This function is used in order to remove local repository files from working tree or index
##
remove()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $REMOVE_REC
		then
			OPTIONS="$OPTIONS -r"
		fi
		if isTrue $REMOVE_CACHED
		then
			OPTIONS="$OPTIONS --cached"
		fi
		if isTrue $REMOVE_DRY
		then
			OPTIONS="$OPTIONS --dry-run"
		fi
		if isTrue $REMOVE_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $REMOVE_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		FILENAME="FILENAME"
		while [ "$FILENAME" != "" ]; 
		do
			echo -e "$COLOR_INFO"
			echo -e "Please, enter the name of the file or directory you wish to remove (no name to stop) : $NORMAL"
			read FILENAME
			if [ "$FILENAME" != "" ]
			then
				if [ -d "$FILENAME" ]
				then
					git rm $OPTIONS "$FILENAME"
					echo -e "$COLOR_SUCCESS"
					echo -e "Directory $FILENAME successfully removed ! $NORMAL"
				else
					if [ -e "$FILENAME" ]
					then
						git rm $OPTIONS "$FILENAME"
						echo -e "$COLOR_SUCCESS"
						echo -e "File $FILENAME successfully removed ! $NORMAL"
					else
						echo -e "$COLOR_FAILURE"
						echo "Unable to remove $FILENAME, file or directory not found !"
					fi
				fi

			fi
		done
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to clean."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# move
# This function is used in order to move or rename file from the index
##
move()
{
	if [ -d .git ]
	then
		OPTIONS=""
		if isTrue $MOVE_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $MOVE_DRY
		then
			OPTIONS="$OPTIONS --dry-run"
		fi
		if isTrue $MOVE_VERBOSE
		then
			OPTIONS="$OPTIONS --verbose"
		fi
		echo -e "$COLOR_INFO"
		echo -e "Do you want to rename a file or directory ? $COLOR_NORMAL"
		if confirm
		then
			FILENAME="FILENAME"
			while [ "$FILENAME" != "" ]; 
			do
				echo -e "$COLOR_INFO"
				echo -e "Please, enter the name of the file you want to rename (no name to stop) : $NORMAL_COLOR"
				read FILENAME
				if [ "$FILENAME" != "" ]
				then
					echo -e "$COLOR_INFO"
					echo -e "Please, enter new name: $NORMAL_COLOR"
					read NAME
					git mv $OPTIONS $FILENAME $NAME
				fi
			done
		else
			FILENAME="FILENAME"
			while [ "$FILENAME" != "" ]; 
			do
				echo -e "$COLOR_INFO"
				echo -e "Please, enter the name of the file you want to move (no name to stop) : $NORMAL_COLOR"
				read FILENAME
				if [ "$FILENAME" != "" ]
				then
					echo -e "$COLOR_INFO"
					echo -e "Please, enter destination folder: $NORMAL_COLOR"
					read FOLDER
					git mv $OPTIONS $FILENAME $FOLDER
				fi
			done
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to clean."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# branch
# This function is used in order create or delete branches
##
branch()
{
	if [ -d .git ]
	then
		echo -e "$COLOR_INFO"
		echo -e "Do you want to create a new branch ? $COLOR_NORMAL"
		if confirm
		then
			echo -e "$COLOR_INFO"
			echo -e "Please, enter a name for your branch : $COLOR_NORMAL"
			read BRANCH_IN
			echo -e "$COLOR_INFO"
			echo -e "You are about to create a new branch with the same configuration of your current one, are you sure ? $COLOR_NORMAL"
			if confirm
			then
				git checkout -b $BRANCH_IN
			else
				return 0;
			fi
		else
			echo -e "$COLOR_INFO"
			echo -e "Do you want to delete an existing branch ? $COLOR_NORMAL"
			if confirm
			then
				echo -e "$COLOR_INFO"
				echo -e "Please, enter a branch name to be deleted : $COLOR_NORMAL"
				read BRANCH_IN
				echo -e "$COLOR_INFO"
				echo -e "You're about to delete branch named $BRANCH_IN, are you sure $COLOR_NORMAL?"
				if confirm
				then
					if isDeleteBoth
					then	
						git branch -d $BRANCH_IN
						git push origin :$BRANCH_IN
					else
						if isDeleteLocal
						then
							git branch -d $BRANCH_IN
						else
							if isDeleteRemote
							then
								git push origin :$BRANCH_IN
							fi
						fi
					fi
				else
					return 0;
				fi
			else
				return 0;
			fi
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to create or delete branches."
		echo -e "$COLOR_NORMAL"
	fi
}

##
# checkout
# This function is used in order to checkout branches, files or changes
##
checkout()
{
	if [ -d .git ]; 
	then
		OPTIONS=""
		if isTrue $CHECKOUT_FORCE
		then
			OPTIONS="$OPTIONS --force"
		fi
		if isTrue $CHECKOUT_QUIET
		then
			OPTIONS="$OPTIONS --quiet"
		fi
		echo -e "$COLOR_INFO"
		echo -e "Do you want to change your current branch ? $COLOR_NORMAL"
		if confirm
		then
			echo -e "$COLOR_INFO"
			echo -e "Do you want to commit your work first ? $COLOR_NORMAL"
			if confirm
			then
				commit
			fi
			echo -e "$COLOR_INFO"
			echo -e "Please enter a branch name: $COLOR_NORMAL"
			read BRANCH_IN
			git checkout $OPTIONS $BRANCH_IN
		else
			return 0;
		fi
	else
		echo -e "$COLOR_FAILURE"
		echo "This directory isn't a git repository."
		echo -e "Please, create a git repository with the $COLOR_NORMAL init $COLOR_FAILURE command before any attempt to create or delete branches."
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
	if isActionAdd $ACTION
	then
		add
	fi
	if isActionCommit $ACTION
	then
		commit
	fi
	if isActionPush $ACTION
	then
		push
	fi
	if isActionPull $ACTION
	then
		pull
	fi
	if isActionReset $ACTION
	then
		reset
	fi
	if isActionLog $ACTION
	then
		log
	fi
	if isActionClean $ACTION
	then
		clean
	fi
	if isActionRm $ACTION
	then
		remove
	fi
	if isActionMv $ACTION
	then
		remove
	fi
	if isActionBranch $ACTION
	then
		branch
	fi
	if isActionCheckout $ACTION
	then
		checkout
	fi
done