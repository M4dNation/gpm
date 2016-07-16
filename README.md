# Git Project Manager

## ABOUT

GPM (Git Project Manager) is an utility entirely written in bash enabling Git repository configuration and source code versionning
with a question/answer configuration without knowing any command. Many functionnalities are handled, please check the section called **Functionnalities** for more information.

## AUTHORS

GPM is maintained by Axel Vaindal & M4dNation's team.

## Contributors

There is actually no other contributors for this project. If you want to contribute, feel free to make any suggestions you want or to contact me.

## LICENCE

GPM is available under the terms of the GNU GENERAL PUBLIC LICENSE. Check the licence file for more details.

## Functionnalities

#### General information 

Before anything, your project should have a **contrib** folder in which you have to put this **gpm.sh** script.
By the way, you should always call this script from the root of your project folder.
For example, if your project has the following tree organisation : 

- contrib
	- gpm.sh
- examples
	- test 1
	- test 2
- src

Then, remember that any call of the script from one of those folders will make the script use relatives links interprated from its calling location and not from the file location, as it's usually the case with any shell command.

To launch the script, use the following command :

    bash contrib/gpm.sh
or
    
    ./contrib/gpm.sh

If any permission error occures, please use the following command to add execution write:

	chmod +x contrib/git.sh

If everything runs well, you should have a greeting in your shell interface and a question about the command you want to execute.
Any execution must be confirmed with a "yes" answer, which is **case-insensitive**. Any other than a "yes or no" expected answer will be considered as a no.

You can also give the script a parameter, which should be the command you want to execute.
For example, if you want to display logs of your repository, then use the following:

	bash contrib/gpm.sh log
or

	./contrib/gpm.sh log

You can enter the **help** command to see the list of any command available. 
You can also have a description of any command thanks to **help**.

GPM works thanks to a lot of functions available in the **.gpm** folder. 
You need to put this folder inside the root of your project (so **contrib** and **.gpm** are at the same level).

Finally, the contrib folder as a **.gpmconfig** folder which can be populate with **.gitconfig.cfg** which are the configuration files of GPM.
You can have as many configuration files as you like in the folder, but remember that GPM always uses one configuration file at a time and the used one must be named **.gitconfig.cfg**.

Here is the final project organisation you should have:

- contrib
	- gpm.sh
	- .gpmconfig
		- .gitconfig.cfg
- examples
	- test 1
	- test 2
- .gpm
	- .actions.cfg
	- .functions.cfg
- src

#### Create and configurate

If your folder is already a git repository and is properly configured, you can skip this section and go to the next one.
However, if you have any doubt about your git configuration or if you project isn't in a repository yet, use the following explanations to make it.

In this section, we will use two differents commands:

    init
and

    config

Use the **init** command if you want to create a new git repository. 
You just need to confirm with the "yes" answer to create your repository
The second question is to set your repository as a bare repository, answer "no" if you just want to make a working repository.
If everything runs well, a green confirmation should appear. 
If your folder is already a git repository, a red alert should inform you about it.

The **init** command should be the first to be called when you start a project, considering than any other command aren't going to be functional as long as your folder is not a git repository.
Besides, even if all commands will be available after **init** is called, you should call **config** just after your **init** call and make the configuration, avoiding many errors when git will be called.

Just answer **config** when the script asks you what you want to do to configure your git repository.
The script will read your **author name** and your **email** from your configuration file to authenticate you in your git calling (such as commit for example).
You can also make, if you want, this configuration either :

- A global configuration
- A system configuration

If you choose to make your configuration a **global configuration**, your configuration will be put for all other git project used with this system session.
If you choose to make your configuration a **system configuration**, your configuration will be put for the entire system.
If neither the global nor the system configuration fits you for personal reasons, just put **local** on the configuration file to make your configuration a **local configuration** for your project.

I personnaly use a **global configuration**, considerating I don't have to change my naming during my git usage, no matter the project I work on (but default is **local** inside the configuration file).

If you want to clone an already existing repository, you can use the **clone** command.
It will ask you for the remote address of the repository, and then clone it wherever you want to.

#### Configuration remote functionnality

You can skip this section if you don't want to use a remote website to handle your git information such as Github or Bitbucket (this would be a terrible mistake !).

A lot of developers use remote website to handle their git configuration, in order to find informations the easiest way possible. 
The most known of this website is Github : http://github.com .

To link your local repository with the remote one created on Github, you will need to use the **remote** command.
First, GPM asks you if you want to see your current remote configuration. If you agree, it will show you both remotes name and URL, so you can be fully aware of what is your current configuration and what changes you wanna make.

After that, you can either add or remove a remote repository from your configuration. All you need to do is answer both name and URL question to add the new one (just the name question is necessary to remove an already configured remote repository).

#### First development

From now on, we will take as granted that you use GPM inside a development project, and you have few changes to archive in your repository.

To do so, you need to use the **commit** command.
Provide asked informations and GPM will ask you if you want to push your commit on a remote branch.
If you do so, you must have configured a remote repository, as seen in the previous section.
You can also choose to push your commit manualy, using the **push** command. 

Either way, GPM will ask you to enter the remote branch name where it can push your commit to. 
Just enter the name and press enter key to see how magic it is. 
No parameter, no difficult command, you just commited and pushed stuff in one blow without any difficulties.

Note that you can also pull some work from the remote branch using the **pull** command.
Pull works the same way as **push**.

During the **commit** process, GPM call another function named **add** in order to add modified file to the index of the git repository.
Configuration about the **add** command can be made inside the configuration file.
Of course, you can also call **add** manually if you want to. 

## CHANGELOG

Version 3.0.0
----------------------------
- Add configuration file
- Split script files
- Blame
- Tag
- Move
- Remove
- Stash
- Fetch

Version 2.0.0
----------------------------
- Status
- Diff
- Revert
- Reset
- Rebase
- Reflog
- Clean

Version 1.1.0
----------------------------

- Checkout
- Clone


Version 1.0.0
----------------------------

- Branch
- Remote
- Add
- Pull
- Merge

I also added many error handling inside previous and current functionnalities.
A dedicated tutorial is also available in the **Functionnalities** section.

Version 0.0.1 (13/05/2015)
----------------------------

- Init
- Config
- Log
- Push
- Commit
