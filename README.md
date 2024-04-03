 # Git Summary Assignment

**Name:** Olga Wieromiejczyk
**Date:** 02/04/2024

This document serves as a summary of the most important Git commands and concepts learned during the assignment.

## Table of contents

- [Add files to the repository](#Add-files-to-the-repository)
- [Edit files](#Edit-files)
- [Commit changes](#Commit-changes)
- [Branching and merging](#Branching-and-merging)
- [Restoring](#Restoring)
- [Merging conflicts](#Merging-conflicts)
- [Pulling changes](#Pulling-changes)

## Add files to the repository

After cloning the new repository now you can start your project.

1. Create a python scripts with your favorite text editor (NOT word processor.  Text editors are; NotePad, TextEdit, Gedit, nano, Sublime, Atom, etc. ).
2. Start tracking the file with git.
```
git add Hello_World.py
```
 - If you want to track **all files in the directory* at once you can do:
```
git add .
```
3. Commit (create a snapshot of the file)
    * Add a message indicating that is the first commit
```
git commit -m "my first commit"
```
4. Save the changes in the cloud (GitHub)
```
git push origin main
```
 - origin is the default name Git gives to the server you cloned from:
5. Go to GitHub and you should see the [Hello_World.py](hello_world.py) file in the repository.


## Edit files

1. Let's edit the file Hello_world.py
3. See differences with last committed version.
```
git diff
```
2. Stage all modified files.
    * Git has a staging area in which it stores files with changes you want to save that haven't been saved yet. Putting files in the staging area is like putting things in a box, while committing those changes is like putting that box in the mail: you can add more things to the box or take things out as often as you want, but once you put it in the mail, you can't make further changes.
```
git add -u
```
3. If you check the status ``git status`` it will show you that the file has "changes to be committed". The snapshot has not yet been created.

    
---------

## Commit changes

1- Now, create a "snapshot" of the current files
```
git commit -m "add cat"
```

 * If you accidentally mistype a commit message, you can change it using the ```--amend``` flag.


```
git commit -m "add bat"
git commit --amend -m "add cat"
```


2- Save changes on GitHub

```
git push
```
3- You can see the changes and compare versions in GitHub



-----------

## Branching and merging

Allows you to diverge from the main branch. The main branch reminds unhatched while you experiment in the branch.  If you are happy with the new branch, you can later make it the main one.

1- Create  new branch

```
git branch new_branch
```

2- Change working branch to the "new_branch"

```
git checkout new_branch
```

3- Edit a file (i.e. Hello_World.py))

4- Stage and commit the changes to the new branch

```
git add -u Hello_world.py
git commit -m "first commit to new branch"
git push origin new_branch
```

5- Compare the 2 branches

```
git diff main..new_branch
```

6- Go back to main branch

```
git checkout main
```

7- Merge the branch to main

```
 git merge new_branch
 git push
 ```
 * Now main branch contains the changes made on the new branch

---------------

## Restoring

1- See all the commits:
```
git log
```
2- Find the commit id we want to restore.

```
git checkout <commit ID>
```
3-Edit the file and:
```
git add -u  Hello_world.py
git commit -m "change the past"
```
4-  NO, we can't change the past (git commit gives error). But we can make a branch and commit
```
git branch back_to_the_future
git checkout  back_to_the_future
git push origin back_to_the_future
```

5- Make the recovered version the main

```
git checkout main
git merge back_to_the_future
```

*If you only want to restore a single file (i.e. Hello_world.py ):

```
git checkout <commit ID> Hello_world.py 
```

--------------

## Merging conflicts

 Typically happens When same lines have been changed independently and Git cannot automatically determine what is correct.

1- Create 2 branches

```
git branch branch_1
git branch branch_2
git branch
```
2 - Go to branch_1 and edit 1st line
```
git checkout branch_1
git ad -u Hello_world.py
git commit -m "SayHi function"
git push origin branch_1
```
2 - Go to branch_2 and edit 1st line
```
git checkout branch_2
git add -u Hello_world.py
git commit -m "Hello Bob"
git push origin branch_2
```
3- Now go back to branch_1 and try to merge it with branch_2
 ```
 git checkout  branch_1
 git diff branch_1..branch_2
 git merge branch_2
 ```
 * We get a merging conflict error
 ```
Auto-merging Hello_world.py
CONFLICT (content): Merge conflict in Hello_world.py
Automatic merge failed; fix conflicts and then commit the result.
```
4- See details
```
git log --merge
```
5- Git didn't know which version is correct, so put both of them in the "Hello_world.py" using these symbols

```
<<<<<<< HEAD
Content of latest edited branch
=======
Content of the other branch
>>>>>>> branch_1
```

6- Delete the "unwanted"" lines and commit

```
git add -u Hello_world.py
git commit -m "Fix merge"
git push origin git push 

```

7- Go to main branch and notice that it hasn't changed, lets update it with content from branch_1,

```
git checkout main
git merge branch_1
```


-----------

## Pulling changes

- Update your local files with the changes available in remote (GitHub) files.
    - Maybe your worked on the same project in 2 different computers (i.e. my desktop and cluster), or you collaborated with someone. This can result in the remote files being ahead of your local files .



1- I clone the project in a new device (in this example I clone it in another directory) that I call **Machine_2**.
```
git clone [https adress to github repository]
```
 * This Downloads all the files

2- Now I edit the files and commit the changes in **Machine_2** and push them to main branch.
```
git add -u Hello_world.py
git commit -m "add date"
git push origin main
```
3- I go back to work in the main branch of **Machine_1**, but changes made on **Machine_2** are not there. I have to pull the changes from GitHub.
```
git config --global pull.ff only  ## configigure pull behavior
git pull
```
* This will update my local version of the main branch.


### Common conflict

- When the same file in the same branch has been edited independently by different users/machines. (Not recommended, better to create different branches for each machine/user).


1- Edit, commit, and push main branch from **Machine_1**.
```
git add -u Hello_world.py 
git commitn -m "changes from machine_1"
git push
```
2- Edit, commit and push form **Machine_2** will get you an error. Because the remote main branch is ahead of you. 
```
git add -u Hello_world.py 
git commitn -m "changes from machine_2"
git push
```
 * Git is preventing you to erase the pushed changes. You can't pull either, git tries to protect your local changes.
3- Git fetch will download the info from GitHub without performing any changes to your local files
```
git fetch
git merge origin main
```
4- We now can see and solve the merging conflicts as before
5- Commit and push changes
```
git add -u Hello_world.py 
git commit -m "resolve merge machine1 and machine2"
```



-----------


## Basic Git commands

- ```git clone```: Clones a remote repository to your local machine.
- ```git init```: Initialize repository.
- ```git status```: Shows modified and staged files.
- ```git add```: Select files that will be committed.
- ```git commit```: Creates a "snapshot" of your files.
- ```git push```: Send committed files to remote server (i.e. GitHub).
- ```git branch```: Create new branch.
- ```git checkout```: Changes working branch.
- ```git merge```: Merges content of different branches.
- ```git pull```: Downloads from remote and merges with local
- ```git fetch```: Downloads info from remote, but does not merge with local.
- ```git show```: Shows the contents of a single commit.

More details in the Git commands [CheatSheet](https://education.github.com/git-cheat-sheet-education.pdf)