#!/bin/bash

# $1 => Process App
# $2 => Track Acronym
# $3 => Snapshot Name

LOCAL_GITREPO='/g/Github';

unzip "$SCRIPTS_DIR/temp/$UNIQUE_FILE_NAME.zip" -d "$LOCAL_GITREPO/$p_app/"
