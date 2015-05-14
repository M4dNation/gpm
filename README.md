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

### Initialize Git and Configuration 

Before anything, your project should have a **contrib** folder in which you have to put this **git.sh** script.
By the way, you should always call this script from the root of your project folder.
For example, if your project has the following tree organisation : 
 
    (we suppose we're a now in /path/to/project/)

- src
- examples
	- test 1
	- test 2
- contrib

Then, remember that any call of the script from one of those folders will make the script use relative link interprated from its calling location and not from the file location, as it's usually the case with any shell command.

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