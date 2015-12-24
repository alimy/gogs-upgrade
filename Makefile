RM= rm -rf
CP= cp -rf
MKDIR= mkdir -p

backup_path= .backup
gogs_path= /home/golang/go/src/github.com/gogits/gogs
gogs_assets= {gogs,public,templates}
gogs_from= $(gogs_path)/$(gogs_assets)

Clean_Gogs= $(RM) ./$(gogs_assets)
Remove_Backup= $(RM) $(backup_path)
Do_Upgrade= $(CP) $(gogs_from) .
Do_Rollback= $(CP) $(backup_path)/$(gogs_assets) .
Do_Backup= $(CP) $(gogs_assets) $(backup_path)

upgrade: backup clean
	$(Do_Upgrade)
	
backup:	
	$(Remove_Backup) || true
	$(MKDIR) $(backup_path)
	$(Do_Backup) || true

rollback:
	[ -d $(backup_path) ] && $(Clean_Gogs) && $(Do_Rollback)

clean:	
	$(Clean_Gogs) || true

distclean: clean
	$(Remove_Backup) || true

test:
	./gogs web || true

.PHONY: upgrade backup rollback clean distclean test

