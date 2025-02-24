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

![[Pasted image 20250106094912.png|1000]]

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

https://juejin.cn/post/7038093620628422669

https://hackmd.io/@vincentlee/SygUerbcL

- 合代码到公共分支上时用git merge
- 合代码到个人分支时用git rebase，形成线性提交历史记录

https://juejin.cn/post/6844904037452627981
#### basic
```
# 如果feature_branch有在remote上的話要做git push --force-with-lease
# 如果feature_branch沒有在remote上的話不用做git push --force-with-lease

git switch <master_branch>
# check master_branch need to be up-to-date
git switch <feature_branch>
git rebase <master_branch>
git push --force-with-lease
# git push --force-with-lease會去整理因爲rebase之後的feature_branch_remote與master_branch_remote的歷史關係
# rebase之後，feature_branch的commit_id會被破壞，且feature_branch的歷史關係圖可能會改變
# 如果不處理，remote的歷史關係可能會分叉，分叉可能導致不預期的side effect
git switch <master_branch>
git merge <feature_branch>
```

example: https://ywctech.net/tech/git-feature-branch-devel-ops/

```bash
# 本來本地跟遠端的 ML-1234-add-dropout 在同一條線上

$ git l
* 5412270 (HEAD -> feature/ML-1234-add-dropout) readme +4
* ac00862 (origin/feature/ML-1234-add-dropout) Update README
| * d9c4b49 (origin/main, origin/HEAD, main) Add more content in sl.txt
|/  
* 3e4a27a add my file
* b91f843 Initial commit

$ git rebase main feature/ML-1234-add-dropout
Successfully rebased and updated refs/heads/feature/ML-1234-add-dropout.

# 本地 rebase main 以後反而分岔了 -- 因為 main 也走出自己的路

$ git l
* 5c4d18a (HEAD -> feature/ML-1234-add-dropout) readme +4
* 755b237 Update README
* d9c4b49 (origin/main, origin/HEAD, main) Add more content in sl.txt
| * ac00862 (origin/feature/ML-1234-add-dropout) Update README
|/  
* 3e4a27a add my file
* b91f843 Initial commit

# 直接 push 會出錯, 因為遠端的 ac00862 跟本地的 5c4d18a 已經在不同的路上

$ git push
To github.com:myname/test-repo.git
 ! [rejected]        feature/ML-1234-add-dropout -> feature/ML-1234-add-dropout (non-fast-forward)
error: failed to push some refs to 'github.com:myname/test-repo.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

# 為了 commit 歷史簡潔，其實可以不用 merge, 而用 push --force-with-lease

$ git push --force-with-lease
...
...
To github.com:myname/test-repo.git
 + ac00862...5c4d18a feature/ML-1234-add-dropout -> feature/ML-1234-add-dropout (forced update)

$ git l
* 5c4d18a (HEAD -> feature/ML-1234-add-dropout, origin/feature/ML-1234-add-dropout) readme +4
* 755b237 Update README
* d9c4b49 (origin/main, origin/HEAD, main) Add more content in sl.txt
* 3e4a27a add my file
* b91f843 Initial commit

# 舊的遠端 feature branch 本來指向 ac00862, 現在就更新成跟本地一樣的 5c4d18a
```
![[Pasted image 20241220181756.png | 500]]

ref: https://www.youtube.com/watch?v=8jQGBYZpdiI

#### rebase_onto

類似cherry-pick

ref: https://medium.com/%E5%BE%9E%E9%9B%B6%E9%96%8B%E5%A7%8B%E7%9A%84%E6%94%BB%E5%9F%8E%E7%8D%85%E7%94%9F%E6%B4%BB/git-%E5%AD%B8%E7%BF%92%E7%AD%86%E8%A8%98-cherry-pick-%E8%88%87-rebase-%E7%9A%84%E5%B7%AE%E5%88%A5-c8f98c09b5f0

cherry-pick
1. 不會產生detach
2. 跟最近的**一個commit_id**比較

rebase --onto
1. 會產生detach
2. 跟**所有的commit_id**比對

ref: https://medium.com/%E4%B8%80%E5%80%8B%E5%B0%8F%E5%B0%8F%E5%B7%A5%E7%A8%8B%E5%B8%AB%E7%9A%84%E9%9A%A8%E6%89%8B%E7%AD%86%E8%A8%98/git-%E7%94%A8-rebase-%E5%90%88%E4%BD%B5%E5%88%86%E6%94%AF-%E8%AE%93%E4%BD%A0%E7%9A%84-git-history-%E6%9B%B4%E4%B9%BE%E6%B7%A8-ae0208c9fb52

```
git rebase --onto <target_branch> <begin_commit_id>^ <end_commit_id>
# which cause detached
git checkout -b <new_branch_name>
git checkout <target_branch>
git merge
```

如果detach怎麽處理

```
git checkout <branch_name>
```

![[Pasted image 20241225184959.png | 1000]]

#### cherry-pick

```
git cherry-pick <begin_commit_id>^ <end_commit_id>
```

#### rebase -i

將已經push remote的多個commit合并成一個commit

```
git rebase -i HEAD~<number>
# replace p with s excluding first commit
git push --force-with-lease
```
### branch

#### create_new_branch

```
git checkout -b <new_branch_name>
git push --set-upstream origin <new_branch_name>
```

#### move_branch

```
# 使用git rebase --onto來取代cherry-pick的時候會使<branch_name>落後
# 移動branch_name用以下方式處理
git br -f <branch_name> <commit_id>
git co <branch_name>
```

### detached

```
(HEAD, <branch_name>) 這個是detach狀態，HEAD是指向<commit_id>，不是指向<branch_name>
(HEAD -> <branch_name>) HEAD是指向<branch_name>
```
### reset

注意stash本身也是一種commit

go to commit_id

```
git reset --hard <commit_id>
```

go to remote/original/HEAD

```
git reset --hard origin/<branch_name>
```

go to local HEAD
```
git reset --hard HEAD
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

### git push

刪除已經push remote的commit

ref: https://pjchender.dev/app/cli-git/

```
git push --force-with-lease origin 'HEAD^:<branch_name>' # 刪除已經 push 到遠端的 commit，但本地端的 commit 還會在，要自己 reset [參考資料]
```

```
git push --force-with-lease origin 'HEAD~<number>:<branch_name>'
git reset --hard origin/<branch_name>
```
### conflict_tool

ref: https://www.youtube.com/watch?v=57x4ZzzCr2Y

https://learngitbranching.js.org/?locale=zh_CN

https://myapollo.com.tw/blog/git-tutorial-rebase/
```
此外，對於 rebase 使用不慎時，我們會希望能夠直接回復到 rebase 之前的狀態，以下就是幾個指令可以用來回復到 rebase之前的狀態

$ git reset --hard ORIG_HEAD

$ git tag BACKUP $ ... # rebase 過程 $ ... # rebase 過程 $ git reset --hard BACKUP # 失敗的話可以直接回復到 tag BACKUP

$ git reflog # 尋找要回復的 HEAD ，以下假設是 HEAD@{3} $ git reset --hard HEAD@{3} # 回復
```

利用 Git Rebase 的互動模式介面，可以快速的整理 Commit，讓我們的變更紀錄更容易理解。但 rebase 的操作是會變更整個歷史，要注意一點是**`不要在共用的分支進行 rebase`**，會造成其他人的歷史紀錄亂掉。

https://medium.com/starbugs/use-git-interactive-rebase-to-organize-commits-85e692b46dd

## fef