#!/bin/sh

svnbasedir="/var/lib/svn"
svnbackupdir="/usr/share/svn/backup/"
svnexternalbackupdir="192.168.0.6:/media/hdd/svnbackup"
numberofbackups=6
echo "*** Backing up subversion repositories..."

cd ${svnbasedir}
for repo in * ; do
    echo ""

    mkdir -p ${svnbackupdir}
    /usr/bin/svn-hot-backup --archive-type=bz2 --num-backups=${numberofbackups} ${svnbasedir}/${repo} ${svnbackupdir}

    if [ "$?" != "0" ]; then
        echo "!!! Backup failed on repository: ${repo}"
    fi
done
echo ""
echo "copy files to ${svnexternalbackupdir}"
scp ${svnbackupdir}/* ${svnexternalbackupdir}

echo "*** Backup finshed"
