# gogs-upgrade
Gogs upgrade from source build

# Usage

* copy the Makefile to gogs's deploy directory.(eg: /home/git/gogos)
* configure go enviroment.
* ```make help``` or ```make``` in gogs's deploy directory see help info.
* ```make update``` update gogs from source build.
* ```make upgrade``` upgrade gogs from source build.

# Snopshot

```
alimy@gility gogs$ make help
    help		- Print help infomation about this
	update		- Update gogs to new version but not dependents
	upgrade		- Upgrade gogs to new version include update dependents
	serve		- Serve gogs to test
	backup		- Just backup gogs''s assets to .backup directory
	rollback	- Rollback gogs to previous build version
	clean		- Clean gogs assets but not configure files
	distclean	- Distclean gogs assets and backup
```
