# ref
https://zhuanlan.zhihu.com/p/613401479
https://zhuanlan.zhihu.com/p/564884836
https://blog.csdn.net/luoganttcc/article/details/127863258

# relevant ref
https://blog.csdn.net/luoganttcc/article/details/127863258
https://blog.csdn.net/edablog/article/details/9033249
https://zhuanlan.zhihu.com/p/613869870

# README
linux distribution: Ubuntu 22.04.2 LTS

```
#copy from HDD to ubutnu for synopsys dir
sudo apt-get install tar
cd ~/synopsys/Installer/Installer3.2
chmod +x SynopsysInstaller_v3.2.run
```
/home/jnjn0022/synopsys/Installer/Installer3.2
```
sudo apt-get install csh
./setup.sh
```
/home/jnjn0022/synopsys/Installer/Scl11.9
/home/jnjn0022/synopsys/scl
/home/jnjn0022/synopsys/Installer/Vcs2016
/home/jnjn0022/synopsys/vcs
/home/jnjn0022/synopsys/Installer/Verdi2016
/home/jnjn0022/synopsys/verdi
```
sudo apt install net-tools
ifconfig
hostname
```
crack
```
cd /home/jnjn0022/synopsys/scl
mkdir license
cd /home/jnjn0022/synopsys/scl/license
```
copy Synopsys.dat in to /home/jnjn0022/synopsys/scl/license
In Synopsys.dat
1. remove \^M
2. DAEMON snpslmd /home/jnjn0022/synopsy/scl/amd64/bin/snpslmd
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install lsb-core
sudo apt-get install iptables
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables-save
sudo apt-get install iptables-persistent
sudo netfilter-persistent save
sudo netfilter-persistent reload

sudo mkdir /usr/tmp
sudo mkdir /usr/tmp/.flexlm

killall lmgrd
lmg_scl

#verdi
sudo rm -f /bin/sh
sudo ln -s /bin/bash /bin/sh
sudo add-apt-repository ppa:linuxuprising/libpng12
sudo apt-get update
sudo apt-get install libpng12-0
```
```
cd
mkdir install_g++-4.8
cd install_g++-4.8/
sudo apt update
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/g++-4.8_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libstdc++-4.8-dev_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/gcc-4.8-base_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/gcc-4.8_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libgcc-4.8-dev_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/cpp-4.8_4.8.5-4ubuntu8_amd64.deb 
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libasan0_4.8.5-4ubuntu8_amd64.deb  
sudo apt install ./gcc-4.8_4.8.5-4ubuntu8_amd64.deb ./gcc-4.8-base_4.8.5-4ubuntu8_amd64.deb ./libstdc++-4.8-dev_4.8.5-4ubuntu8_amd64.deb ./cpp-4.8_4.8.5-4ubuntu8_amd64.deb ./libgcc-4.8-dev_4.8.5-4ubuntu8_amd64.deb ./libasan0_4.8.5-4ubuntu8_amd64.deb ./g++-4.8_4.8.5-4ubuntu8_amd64.deb
```
```
cd ~/synopsys/.test_synopsys
make
```