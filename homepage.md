---
dg-publish: true
dg-home: true
---
# github
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
check .git in your root then in obsidian
```
Git: commit all changes
Git: push
```
issue: fatal: unable to access 'https://github.com/jnjnliwenjie0022/obs.git': Failed to connect to github.com port 443 after 21092 ms: Couldn't connect to server Pushing to https://github.com/jnjnliwenjie0022/obs.git
```
git config --list --show-origin
```
check out checkb which gitconifg is your target 
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
# vercel
https://www.youtube.com/watch?v=eULVrTjT11w&t=615s
https://dg-docs.ole.dev/getting-started/01-getting-started/

create vercel and github template
https://github.com/oleeskild/digitalgarden
in community plugin
```
Digital Garden
```
in digital garden plugin
```
GitHub repo name: obv
GitHub Username: jnjnliwenjie0022
GitHub token:
```
in obsidian, create note
in obsidian cmd
```
Add file property
```
in obsidian, create checkbox dg-publish, and tick checkbox
in obsidian, create checkbox dg-home, and tick checkbox
```
publish
```
in vercel, checkout the website
in obsidian delete
1. .github
2. src
3. .eleventy.js
4. .eleventyignore
5. .env
6. .gitignore
7. netlify.toml
8. package-lock.json
9. package.json
10. plugin-info.json
11. vercel.json
```
publish
```
in vercel, checkout the website