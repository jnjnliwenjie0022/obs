# ref
https://www.youtube.com/watch?v=hZS96dwKvt0

![[git.svg]]
create_new_repo
```
git config --global user.name "jnjn0022"
git config --global user.email "jnjn0022@gmail.com"
```
```
# create new repo on the github

git init
echo "# test" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M master
git remote add origin <url>
git push -u origin master

user:jnjnliwenjie0022
key: token
```
# show
```
git show <branch>
git show <hash>
git show <hash> <file>

git switch <branch> " download to local repo and switch
git peek <branch> 
```
# revert
```
//把此版本的資料回復，此版本必須是被push過的版本
//反向操作 主要操作對象是server，但local也會被影響
git revert (#version number)
```
# branch
```
#create new branch
git checkout -b new_branch


#delete branch
git branch -d new_branch
git push origin --delete new_branch

#rename branch
git branch -m

#show branch
git branch -a

#get branch from remote
git branch -a
git checkout remote_branch
```
# commit
```
# cancel commit
git reset HEAD^
```
# rebase
```
# rebash (In the my_branch, rebase to master)
git stash list
git stash

git switch master
git pull

git switch my_branch
git rebase master
git stash pop
```
# merge
```
# rebash (In the my_branch, merge to master)
git stash list
git stash

git switch master
git pull

git switch my_branch
git rebase master
git push (Let the git graphic update)
git stash pop

git switch master
git merge my_branch
```
# stash
```
git stash list
git stash push
git stash pop (#number)
git stash clear (#number)
```
# checkout
```
git checkout <commit_id>
git switch -

git checkout <commit_id>
git checkout <commit_id>
git checkout master
```
# worktree
https://www.youtube.com/watch?v=4_p1OdLeDLE
```
git worktree add ../tmp existing_branch
git worktree list
cd ../tmp
cd -
git workttree remove tmp
```