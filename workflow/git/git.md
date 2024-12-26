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

#get branch from remote
git branch -a
git checkout remote_branch
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

# methodology

```
gitk --all &
git log
git reflog

# commit
## cancel commit
git reset --mixed HEAD^

git reset --soft  # Commit 拆出來的檔案丟回暫存區
git reset --mixed # Commit 拆出來的檔案丟回工作目錄
git reset --hard  # Commit 拆出來的檔案直接丟掉

## go to another commit
git reset --hard
git reset --hard HEAD@{N}

# branch
## show branch
git branch -a

## switch to newbranch
git checkout <switch_branch>
	# explain
	if (switch_branch is not in local)
		git checkout -b <switch_branch>
		git branch   -u <remote_name>/<switch_branch> # 追蹤switch_branch


```
## a_successful_git_branching_model

![[Pasted image 20241007164708.png]]
### local_repository
```
# remote
## show remote_name
git remote -v

## add local repository
git remote add <remote_name> <local_path>

# fetch
## updata commit tree 
git fetch <remote_name>
```

![[Pasted image 20241007164338.png]]
### rebase
```
# 如果feature_branch有在remote上的話要做git push --force-with-lease
# 如果feature_branch沒有在remote上的話不用做git push --force-with-lease

git switch <master_branch>
# check master_branch need to be up-to-date
git switch <feature_branch>
git rebase <master_branch>
git push --force-with-lease
# git push --force-with-lease會整理因爲rebase之後feature_branch_remote與master_branch_remote的歷史關係
# 如果不處理這個remote的歷史關係可能會分叉，分叉可能導致不預期的side effect
git switch <master_branch>
git merge <feature_branch>
```
![[Pasted image 20241220181756.png]]
### branch
```
git checkout -b <new_branch_name>
git push --set-upstream origin <new_branch_name>
```

### reset
go to commit_id by reset
```
git stash -m 'before git reset --hard'
git reset --hard <commit_id>
```
go back by reset
```
git stash -m 'before git reset --hard'
git reset --hard <destination_commit_id>
git reset --hard <original_commit_id>
git stash clear
// stash is one kind of commit
// need to pop out by using reset HEAD^
git reset HEAD^
```
### merge
```
git stash -m 'before git reset --hard'
git reset --hard <commit_id>
git checkout -b <new_branch_name>
git add
git commit
git checkout <branch_name>
git merge <new_branch_name>
```

### rebase_onto
![[Pasted image 20241225184959.png | 1000]]