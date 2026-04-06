RSYNC="ionice -c3 rsync"
# don't use --progress
RSYNC_ARGS="-vrltD --delete --stats --human-readable"
SOURCES="/dir1 /dir2 /file3"
TARGET="storage::storage"

echo "Executing dry-run to see how many files must be transferred..."
TODO=$(${RSYNC} --dry-run ${RSYNC_ARGS} ${SOURCES} ${TARGET}|grep "^Number of files transferred"|awk '{print $5}')

${RSYNC} ${RSYNC_ARGS} ${SOURCES} ${TARGET} | pv -l -e -p -s "$TODO"