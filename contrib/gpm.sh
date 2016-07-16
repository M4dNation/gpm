#!/bin/bash
# gpm.sh
#
# Git Project Manager is a script utiliy to help during Git Driven Development.
#
#################################################################################

source contrib/.gpmconfig/.gitconfig.cfg
source .gpm/.functions.cfg
source .gpm/.actions.cfg

LOOP=1
while [ $LOOP -gt 0 ]; do
	if [ $# -eq 1 ]
  	then
    	ACTION="$1"
    	LOOP=0
	else
		echo -e "$COLOR_INFO"
		echo -e "Welcome in the git project manager ! What do you want to do ? $COLOR_NORMAL"
		read ACTION
	fi
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
	if isActionTag $ACTION
	then
		tag
	fi
	if isActionStash $ACTION
	then
		stash
	fi
	if isActionMerge $ACTION
	then
		merge
	fi
	if isActionFetch $ACTION
	then
		fetch
	fi
	if isActionRemote $ACTION
	then
		remote
	fi
	if isActionRebase $ACTION
	then
		rebase
	fi
	if isActionReflog $ACTION
	then
		reflog
	fi
	if isActionRevert $ACTION
	then
		revert
	fi
	if isActionBlame $ACTION
	then
		blame
	fi
	if isActionHelp $ACTION
	then
		help
	fi
	if isActionClear $ACTION
	then
		clear
	fi
	if isActionExit $ACTION
	then
		LOOP=0
	fi
done