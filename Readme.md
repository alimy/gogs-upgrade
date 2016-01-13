# gogs-upgrade
Gogs upgrade from source build

# Usage

* copy the Makefile to gogs's deploy directory(eg: /home/git/gogos) or clone
  this repository then do work ```make ...``` and the gogs will deploy in
  work directory.
* configure go enviroment.
* ```make help``` or ```make``` in gogs's deploy directory see help info.
* ```make install``` install gogs from source build(note:make sure you are in
    empty directory that gogs will deployed or just in this repository's
    work tree).
* ```make update``` update gogs from source build.
* ```make upgrade``` upgrade gogs from source build.

# Snopshot

### >go enviroment
```
[git@linux gogs]$ go version
go version go1.6beta1 linux/amd64

[git@linux gogs]$ go env
GOARCH="amd64" h
GOBIN=""
GOEXE=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOOS="linux"
GOPATH="/home/git/go"
GORACE=""
GOROOT="/home/git/opt/go"
GOTOOLDIR="/home/git/opt/go/pkg/tool/linux_amd64"
GO15VENDOREXPERIMENT="1"
CC="gcc"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0"
CXX="g++"
CGO_ENABLED="1"
```

### >gogs snopshot
```
[git@linux gogs]$ ls -l
drwxrwxr-x  3 git git     4096 Dec 22 02:36 custom
drwxrwxr-x  5 git git     4096 Dec 22 02:37 data
-rwxrwxr-x  1 git git 31400320 Jan 11 15:45 gogs
-rw-r--r--  1 git git     1064 Dec 22 02:36 LICENSE
drwxrwxr-x  2 git git     4096 Dec 22 02:36 log
-rw-rw-r--  1 git git     1826 Jan 11 15:52 Makefile
drwxrwxr-x  7 git git     4096 Jan 11 15:45 public
-rw-r--r--  1 git git     7188 Dec 22 02:36 README.md
-rw-r--r--  1 git git     4833 Dec 22 02:36 README_ZH.md
drwxr-xr-x  6 git git     4096 Dec 22 02:36 scripts
drwxrwxr-x 10 git git     4096 Jan 11 15:45 templates

[git@linux gogs]$ ./gogs --version
Gogs version 0.8.19.0111

[git@linux gogs]$ make help
    help		- Print help infomation about this
    install		- Install gogs from source build
    update		- Update gogs to new version but not dependents
    upgrade		- Upgrade gogs to new version include update dependents
    serve		- Serve gogs to test
    backup		- Just backup gogs's assets to .backup directory
    rollback	- Rollback gogs to previous build version
    clean		- Clean gogs assets but not configure files
    distclean	- Distclean gogs assets and backup
```
