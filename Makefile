GPFSDIR=$(shell dirname $(shell which mmlscluster))
CURDIR=$(shell pwd)
LOCLDIR=/usr/local/bin

install: check_fileset_inodes

update: check_fileset_inodes

check_fileset_inodes:   .FORCE
	cp -fp $(CURDIR)/check_fileset_inodes $(LOCLDIR)/check_fileset_inodes

clean:
	rm -f $(LOCLDIR)/check_fileset_inodes

cron:   .FORCE
	echo ' ' >>/var/spool/cron/root
	echo '# Check fileset inode allocations.' >>/var/spool/cron/root
	echo '*/15 * * * * /usr/local/bin/check_fileset_inodes' >>/var/spool/cron/root

.FORCE:


