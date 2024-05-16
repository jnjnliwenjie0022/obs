cd ~
vim .gitconfig
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
