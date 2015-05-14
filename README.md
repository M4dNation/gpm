# Git Project Manager

## ABOUT

GPM (Git Project Manager) is an utility entirely written in bash enabling Git repository configuration and source code versionning
with a question/answer configuration without knowing any command. Many functionnalities are handled, please check the section called **Functionnalities** for more information.

## AUTHORS

GPM is maintained by Axel Vaindal.

## Contributors

There is actually no other contributors for this project. If you want to contribute, feel free to make any suggestions you want or to contact me.

## LICENCE

GPM is available under the terms of the GNU GENERAL PUBLIC LICENSE. Check the licence file for more details.

## Functionnalities

#### General information 

Before anything, your project should have a **contrib** folder in which you have to put this **git.sh** script.
By the way, you should always call this script from the root of your project folder.
For example, if your project has the following tree organisation : 

- src
- examples
	- test 1
	- test 2
- contrib

Then, remember that any call of the script from one of those folders will make the script use relative link interprated from its calling location and not from the file location, as it's usually the case with any shell command.

To launch the script, use the following command :

    sh contrib/git.sh
or
    
    ./contrib/git.sh

If any permission error occure, please use the following command to add execution write:

	chmod +x contrib/git.sh

If everything runs well, you should have a greeting in your shell interface and a question about the command you want to execute.
Any execution must be confirmed with a "yes" answer, which is **case-sensitive**. Any other response to a "yes or no" expected answer will be considered as a no.

#### Create and configurate

If your folder is already a git repository and is properly configured, you can skip this section and go to the next one.
However, if you have any doubt about your git configuration or if you project isn't in a repository yet, use the following explanations to make it.

In this section, we will use two differents command:

    init
and
    config

Use the **init** command if you want to create a new git repository. You just need to confirm with the "yes" answer to create your repository.
If everything runs well, a green confirmation should appear. If your folder is already a git repository, a read alert should inform you about it.

## CHANGELOG

Version 0.0.2 (In progress)
----------------------------

- Add
- Pull
- Merge

Version 0.0.1 (13/05/2015)
----------------------------

- Init
- Config
- Log
- Push
- Commit