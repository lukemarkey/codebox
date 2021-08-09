###########################################################################
## GET INFORMATION ON GIT REPOSITORY
###########################################################################

git remote -v ## GET REMOTE URL

###########################################################################
## CHANGE INFORMATION ON GIT REPOSITORY
###########################################################################

git remote set-url origin git@bitbucket.org:luke-markey/${REPOSITORY}.git

## OVERWRITE LOCAL UNCOMMITED CHANGES

git stash
git pull

# STASH AND APPLY LOCAL CHANGES

git stash
git fetch origin
git rebase origin/master
git stash pop ## REAPPLY LOCAL CHANGES

# REMOVE FILE FROM TRACKING

git rm -r --cached {file_name}

## FORCE PULL

git fetch --all
git reset --hard origin/master

## FORCE PUSH

git push origin master --force

## GIT REMOTE

git remote -v
git remote add origin $URL

## SSH

eval "$(ssh-agent -s)" ## START SSH-AGENT IN BACKGROUND
ssh-agent
ssh-add ~/.ssh/luke_hp
