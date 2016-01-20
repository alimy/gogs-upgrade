RM= rm -rf
CP= cp -rf
MKDIR= mkdir -p

backup_path= .backup
gogs_src= github.com/gogits/gogs
gogs_path= $(GOPATH)/src/${gogs_src}
gogs_git_dir= $(gogs_path)/.git
gogs_git_flag= --git-dir=$(gogs_git_dir) --work-tree=$(gogs_path)
gogs_res= LICENSE,README.md,README_ZH.md,public,templates,scripts
gogs_assets= gogs,$(gogs_res)
gogs_res_from= $(gogs_path)/{$(gogs_res)}

Clean_Gogs_Assets= $(RM) ./{$(gogs_assets)}
Remove_Backup_Gogs= $(RM) $(backup_path)
Checkout_Dev_Gogs= git $(gogs_git_flag) checkout -f develop
Pull_Dev_Gogs= git $(gogs_git_flag) pull
Update_Gogs_Deps= go get -u -v -d -tags "sqlite pam cert" $(gogs_src)
Build_Gogs= go build -v -tags "sqlite pam cert" $(gogs_src)
Update_Gogs_Res= $(CP) $(gogs_res_from) .
Rollback_Gogs= $(CP) $(backup_path)/{$(gogs_assets)} .
Backup_Gogs= $(CP) ./{$(gogs_assets)} $(backup_path)

help:
	@echo "	help		- Print help infomation about this"
	@echo "	install		- Install gogs from source build"
	@echo "	feature		- Test a feature of gogs from source build"
	@echo "	update		- Update gogs to new version but not dependents"
	@echo "	upgrade		- Upgrade gogs to new version include update dependents"
	@echo "	serve		- Serve gogs to test"
	@echo "	backup		- Just backup gogs's assets to .backup directory"
	@echo "	rollback	- Rollback gogs to previous build version"
	@echo "	clean		- Clean gogs assets but not configure files"
	@echo "	distclean	- Distclean gogs assets and backup"

install: dependent clean
	$(Build_Gogs)
	$(Update_Gogs_Res)

update: backup clean checkout
	$(Build_Gogs)
	$(Update_Gogs_Res)

feature: backup clean
	$(Build_Gogs)
	$(Update_Gogs_Res)

upgrade: dependent update

backup:	
	$(Remove_Backup_Gogs) || true
	$(MKDIR) $(backup_path)
	$(Backup_Gogs) || true

rollback:
	[ -d $(backup_path) ] && $(Clean_Gogs_Assets) && $(Rollback_Gogs)

checkout:
	$(Checkout_Dev_Gogs)
	$(Pull_Dev_Gogs)

dependent:
	$(Update_Gogs_Deps)

clean:	
	$(Clean_Gogs_Assets) || true

distclean: clean
	$(Remove_Backup_Gogs) || true

serve:
	./gogs web || true

.PHONY: help install update upgrade feature serve
.PHONY: backup rollback clean distclean
.PHONY: dependent

