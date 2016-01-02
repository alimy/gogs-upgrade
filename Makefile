RM= rm -rf
CP= cp -rf
MKDIR= mkdir -p

backup_path= .backup
gogs_path= $(GOPATH)/src/github.com/gogits/gogs
gogs_git_dir= $(gogs_path)/.git
gogs_git_flag= --git-dir=$(gogs_git_dir) --work-tree=$(gogs_path)
gogs_res= public,templates
gogs_assets= gogs,$(gogs_res)
gogs_res_from= $(gogs_path)/{$(gogs_res)}

Clean_Gogs_Assets= $(RM) ./{$(gogs_assets)}
Remove_Backup_Gogs= $(RM) $(backup_path)
Checkout_Dev_Gogs= git $(gogs_git_flag) checkout -f develop
Pull_Dev_Gogs= git $(gogs_git_flag) pull
Update_Gogs_Deps= go get -u -d -tags "sqlite pam cert" github.com/gogits/gogs
Build_Gogs= go build -tags "sqlite pam cert" github.com/gogits/gogs
Update_Gogs_Res= $(CP) $(gogs_res_from) .
Rollback_Gogs= $(CP) $(backup_path)/{$(gogs_assets)} .
Backup_Gogs= $(CP) ./{$(gogs_assets)} $(backup_path)

upgrade: backup clean dependent
	$(Checkout_Dev_Gogs)
	$(Pull_Dev_Gogs)
	$(Build_Gogs)
	$(Update_Gogs_Res)
	
backup:	
	$(Remove_Backup_Gogs) || true
	$(MKDIR) $(backup_path)
	$(Backup_Gogs) || true

rollback:
	[ -d $(backup_path) ] && $(Clean_Gogs_Assets) && $(Rollback_Gogs)

dependent:
	$(Update_Gogs_Deps)

clean:	
	$(Clean_Gogs_Assets) || true

distclean: clean
	$(Remove_Backup_Gogs) || true

test:
	./gogs web || true

.PHONY: upgrade backup rollback clean dependent distclean test

