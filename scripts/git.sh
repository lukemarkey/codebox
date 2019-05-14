# STASH CHANGES

git stash
git fetch origin
git rebase origin/master
git stash pop

# REMOVE FILE FROM TRACKING

git rm -r --cached {file_name}

# FORCE PULL

git fetch --all
git reset --hard origin/master
