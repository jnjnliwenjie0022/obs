# ref
[GitHub - ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
[0 to LSP : Neovim RC From Scratch (youtube.com)](https://www.youtube.com/watch?v=w7i4amO_zaE&t=1395s)
[Dev Tool Time with ThePrimeagen (youtube.com)](https://www.youtube.com/watch?v=GXxvxSlzJdI&t=2672s)
# relevant ref
[GitHub - craftzdog/dotfiles-public: My personal dotfiles](https://github.com/craftzdog/dotfiles-public)
[How to set up Neovim for coding React, TypeScript, Tailwind CSS, etc on a new M2 MacBook Air (youtube.com)](https://www.youtube.com/watch?v=ajmK0ZNcM4Q)
[How I Setup Neovim On My Mac To Make It Amazing - Complete Guide (youtube.com)](https://www.youtube.com/watch?v=vdn_pKJUda8&t=3524s)
[Neovim is better than VSCode, and I prove it - My plugins setup (youtube.com)](https://www.youtube.com/watch?v=f5-XZadSFBc)
[Productive Workstation with Linux 08 - Compiling Neovim (youtube.com)](https://www.youtube.com/watch?v=adODck89qVk)
[Effective Neovim: Instant IDE (youtube.com)](https://www.youtube.com/watch?v=stqUbv-5u2s)
[Automatically Execute *Anything* in Nvim (youtube.com)](https://www.youtube.com/watch?v=9gUatBHuXE0)
[How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide (youtube.com)](https://www.youtube.com/watch?v=NL8D8EkphUw)
[dotfiles/config/git at main · nicknisi/dotfiles · GitHub](https://github.com/nicknisi/dotfiles/tree/main/config/git)
# uarch
```C
~/
	synopsys/ (manual)
	README.md (manual)
	.workflow.bash (manual)
	.local/ (manual)
		lib/ (manual)
			bash-git-promt/ (download)
			nvim/ (download)
				parser/ (download)
					parser/ (download)
						bash.so (download)
					parser-info/ (download)
						bash.revision (download)
		bin/ (manual)
			fzf*(download)
			fzf-tmux* (download)
			zoxide* (download)
			nvim* (download)
			tmux* (download)
			xsel* (download)
			ctags* (download)
			exa* (download)
			fd* (download)
			rg* (download)
		.script/
			tmux-sessionizer* (manual)
			tmux-back-to-nvim* (manual)
	.config/ (manual)
		tmux/ (manual)
			tmux.conf (manual)
		nvim/ (manual)
			init.lua (manual)
			after/ (manual)
				plugin/ (manual)
					colors.lua (manual)
					harpoon.lua (manual)
					telescope.lua (manual)
					vim_easy_align.lua (manual)
					undotree.lua (manual)
					treesitter.lua (manual)
					lsp.lua (manual)
			lua/ (manual)
				config/ (manual)
					init.lua (manual)
					keymaps.lua (manual)
					packer.lua (manual)
					set.lua (manual)
					ctags.lua (manual)
			ftdetect/ (manual)
				filetype.vim (manual)
				log.vim (manual)
			syntax/ (manual)
				log.vim (manual)

```
# git_pull_tnv_workflow
https://github.com/jnjnliwenjie0022/.dotfiles/tree/master

使用前確保一下的東西都不存在
1. .local/bin/
2. .local/script/
3. .local/lib/
4. .bashrc.workflow
5. .config/tmux/
6. .config/nvim/
## appImage_tmux_neovim
default using jnjnliwenjie0022.git

https://github.com/neovim/neovim/releases

version: Nvim 0.9.2
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim
```
https://github.com/nelsonenzo/tmux-appimage/releases
```
curl -s https://api.github.com/repos/nelsonenzo/tmux-appimage/releases/latest \
| grep "browser_download_url.*appimage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - \
&& chmod +x tmux.appimage
mv tmux.appimage ~/.local/bin/tmux
```
2 ways to execute appimage
1. -appimage-extract and amend the AppRun file
2. installed libfuse2

	https://github.com/AppImage/AppImageKit/wiki/FUSE
	```
	sudo apt-get install libfuse2
	```
### git_with_ssh
```
ssh-keygen -t rsa -b 4096 -C "https://github.com/jnjnliwenjie0022"
Enter
Enter
Enter
eval "$(ssh-agent -s)"
ssh-add -k ~/.ssh/id_rsa

#copy ssh key to github(https://github.com/jnjnliwenjie0022) from ~/.ssh/id_rsa.pub
```
1. pull the file to the current directory
```
git init
git remote add origin git@github.com:jnjnliwenjie0022/.dotfiles.git
git pull git@github.com:jnjnliwenjie0022/.dotfiles.git master
git push --set-upstream origin master
```
2. pull the directory to the current directory
```
git clone git@github.com:jnjnliwenjie0022/.dotfiles.git
```
### git_without_ssh
```
user:jnjnliwenjie0022
key: token
```
https://www.wongwonggoods.com/all-posts/other-skill/debug_error/git-remote-support/
1. pull the file to the current directory
```
git init
git remote add origin https://github.com/jnjnliwenjie0022/.dotfiles.git
git pull https://github.com/jnjnliwenjie0022/.dotfiles.git master
git push --set-upstream origin master
```
2. pull the directory to the current directory
```
git clone https://github.com/jnjnliwenjie0022/.dotfiles.git
```
## ctags
https://github.com/universal-ctags/ctags
```
sudo apt install gcc make pkg-config autoconf automake python3-docutils libseccomp-dev libjansson-dev libyaml-dev libxml2-dev
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$HOME/.local --enable-static
make
make install
```
https://coderwall.com/p/fy7stg/vim-and-systemverilog
https://zhuanlan.zhihu.com/p/371925432
```
# generate UVM tags <leader>rt
```
https://dev.to/oinak/neovim-config-from-scratch-part-ii-11k9
https://blog.csdn.net/haifeng_gu/article/details/72934188
https://stackoverflow.com/questions/14465383/how-to-navigate-multiple-ctags-matches-in-vim
## xsel
defualt using jnjnliwenjie0022.git
```
git clone https://github.com/kfish/xsel
cd xsel
autoconf
./configure --prefix=$HOME/.local
make
make install
```
## fzf & fzf-tmux
defualt using jnjnliwenjie0022.git
https://github.com/junegunn/fzf
https://www.youtube.com/watch?v=_xxTcKJMnWQ
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

cd .fzf
./install
no
no
no
mv ~/.fzf/fzf ~/.local/bin
mv ~/.fzf/fzf-tmux ~/.local/bin
```
## zoxide
defualt using jnjnliwenjie0022.git
https://github.com/ajeetdsouza/zoxide
```
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```
## bash-git-prompt
defualt using github
https://github.com/magicmonty/bash-git-prompt
```
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.local/script/.bash-git-prompt --depth=1
```
## exa
defualt using jnjnliwenjie0022.git
https://github.com/ogham/exa
```
curl -OL https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-musl-v0.10.1.zip
unzip exa-linux-x86_64-musl-v0.10.1.zip -d exa
mv exa/bin/exa $HOME/.local/bin
```
## rg
defualt using jnjnliwenjie0022.git
https://github.com/BurntSushi/ripgrep
```
# copy link from the file
# curl -LO '<link>'
curl -LO 'https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz'
tar xf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
cd ripgrep-13.0.0-x86_64-unknown-linux-musl
mv rg $HOME/.local/bin
```
## fd
defualt using jnjnliwenjie0022.git
https://github.com/sharkdp/fd#installation
```
# copy link from the file
# curl -LO '<link>'
curl -LO 'https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-x86_64-unknown-linux-musl.tar.gz'
tar xf fd-v8.7.0-x86_64-unknown-linux-musl.tar.gz
cd fd-v8.7.0-x86_64-unknown-linux-musl
mv fd $HOME/.local/bin
```
# plugin
## vim_fugitive
https://brookhong.github.io/2016/06/23/use-fugitive-to-diff-branches-or-commits.html
https://www.youtube.com/watch?v=uUrKrYCAl1Y&t=228s
https://www.youtube.com/watch?v=IyBAuDPzdFY
https://www.youtube.com/watch?v=vpwJ7fqD1CE
## treesitter
https://thevaluable.dev/tree-sitter-neovim-overview/
## lsp
https://blog.csdn.net/lxyoucan/article/details/123443937
https://luals.github.io/#install
https://luals.github.io/wiki/build/
https://github.com/LuaLS/lua-language-server/tree/master
## vim_easy_align
[Vim-easy-align 表格格式化/对齐插件 • xu3352's Tech Blog](https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown)
[vim plugin - Vim align text to left side - Stack Overflow](https://stackoverflow.com/questions/51477012/vim-align-text-to-left-side)
## syntax_systemverilog
[systemverilog.vim - Indent & syntax script for Verilog and SystemVerilog : vim online](https://www.vim.org/scripts/script.php?script_id=4743)
# ranking
https://deepu.tech/rust-terminal-tools-linux-mac-windows-fish-zsh/
https://evanli.github.io/Github-Ranking/Top100/Vim-script.html
https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Lua.md
# archive
https://www.youtube.com/watch?v=faoPxXSj8n0
https://www.youtube.com/watch?v=1xKE62tTYj4
https://blog.embeddedts.com/tag-jumping-in-a-codebase-using-ctags-and-cscope-in-vim/
https://zhuanlan.zhihu.com/p/36279445
```
ciw delete and go to insert mode
g; go to previous change
g, go to next change
:changes
:jamps
:marks
dt<char>
dT<char>
```
# grep
https://stackoverflow.com/questions/16956810/find-all-files-containing-a-specific-text-string-on-linux
# find
https://blog.gtwang.org/linux/unix-linux-find-command-examples/