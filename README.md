# dotfiles
Various config files and scripts for linux -- managed via *GNU Stow*


## Quick Setup

### Installation

```
cd
git clone --recursive https://github.com/pallxk/dotfiles.git
cd dotfiles

# Install `stow` first, see 'Installing' section below for instructions.
stow bash       # or any other package you want
# If conflicts reported, backup and remove original ones, and try again.
```

### Update

```
cd ~/dotfiles
git pull
git submodule update --init
```


## [GNU Stow](https://www.gnu.org/software/stow/)
GNU Stow is a symlink farm manager which takes distinct packages of software and/or data located in separate directories on the filesystem (dotfiles of various software in this case), and makes them appear to be installed in the same place (`$HOME` folder in this case).

### Installing

* ArchLinux: `pacman -S stow`
* Ubuntu/Debian: `apt-get install stow`
* CentOS: `yum install epel-release && yum install stow`
* Mac OS: `brew install stow`
* Cygwin: `apt-cyg install stow`

### Futher Reading
* `man stow`
* [Managing your dotfiles with GNU Stow](http://codyreichert.github.io/blog/2015/07/07/managing-your-dotfiles-with-gnu-stow/)
* [Stow Your Dotfiles – GNU Stow for Managing Symlinks](http://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/)
* [使用GNU Stow管理配置文件](http://ruoshan.github.io/archive/2013/10/30/gnu-stow.html)


## Related Work on Dotfiles
* https://github.com/xero/dotfiles (custom linux config files - managed via gnu stow)
