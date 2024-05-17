# clone
## window
### method1
Download https://desktop.github.com/
### method2
ref: https://www.youtube.com/watch?v=5YZz38U20ws

https://git-scm.com/download/win
```
winget install --id Git.Git -e --source winget
```
in community plugin
```
Git
```
check .git in your root then
```
Git: commit all changes
Git: push
```
issue:

## linux
https://hoyipngai.medium.com/%E6%96%B0%E5%AE%89%E8%A3%9Dlinux%E7%9A%84proxy%E8%A8%AD%E5%AE%9A-eaf928878c7a
```
cd ~
vim .gitconfig
```
```
[user]
	name = wen-jie li
	email = jnjn0022@gmail.com
[push]
	default = simple
	followTags = true
[pull]
	rebase = true
[http]
	proxy = http://cache1:3128
	postBuffer = 524288000
[https]
	proxy = http://cache1:3128
[diff]
    tool = vim
[alias]
	co = checkout
	ci = commit
    st = status
    br = branch
    ls = ls-files
    pick = cherry-pick
    sync = fetch --all -p
    lsd = diff --name-only
    tree = log --graph --simplify-by-decoration --pretty=format:'%d' --all
    tlog = log --graph --all --format='%C(red)%h %C(white)%s %Cgreen(%cr)%C(cyan) <%an>%Creset%C(yellow)%d%Creset' --all
    slog = log --graph --format='%C(red)%h %C(auto,blue)%ad %C(auto,green)%aN %C(auto,reset)%s %C(auto,red) %gD' --date=short        --all
    blog = log --graph --format='%C(red)%h%Creset %C(white)%s%Creset %Cgreen(%cr)%Creset %C(cyan)<%an>%Creset %C(yellow)%d%Creset' --first-parent
    olog = log --graph --oneline

    unstash = stash pop
	ff = merge --ff-only
	plrb = pull --rebase
	amend = commit --amend
	squash = commit --squash HEAD
	rev = rev-parse
	ver = rev-parse
	continue = rebase --continue
[advice]
        ignoredHook = false
[credential]
	helper = cache --timeout 99986400
```
```
##without ssh
git clone https://github.com/jnjnliwenjie0022/obs.git

#github(https://github.com/jnjnliwenjie0022) -> Settings -> Developer settings -> Personal access tokens -> Tokens (classic)
```