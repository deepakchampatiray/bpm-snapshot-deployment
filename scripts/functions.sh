#!/bin/bash

buildPAFromTemplate() {
    cat "$SCRIPTS_DIR/../templates/$1" | sed -e "s/<<PROCESS_APP_ACRONYM>>/$2/g" > "$SCRIPTS_DIR/temp/$1"
}

buildPAExportFromTemplate() {
    OUT_FILE=$( escapeWindowsPath $5 );
    #echo $OUT_FILE;
    cat "$SCRIPTS_DIR/../templates/$1" | sed -e "s/<<PROCESS_APP_ACRONYM>>/$2/g;s/<<SNAPSHOT_ACRONYM>>/$3/g;s/<<TRACK_ACRONYM>>/$4/g;s%<<OUTPUT_FILE_PATH>>%$OUT_FILE%g;" > "$SCRIPTS_DIR/temp/$1"
}

escapeWindowsPath() {
    echo $1 | sed 's%\\%\\\\%g';
}


executePyInWsadmin() {
    # echo $0 $1 $2;
    comm="$WSADMIN_PATH\\wsadmin.bat -user $1 -password $2 -f $WINDOWS_BASE_PATH\\scripts\\temp\\$3 > $WINDOWS_BASE_PATH\\scripts\\temp\\out.txt";
    # -user $1 -password $2
    # echo $comm;
    cmd //C "$comm";
}

createGitBranch() {
    # $1 : Local Git repo path
    # $2 : Branch Name
    cd $1;
    # Checkout init branch
    git checkout init;
    # Create and switch to new branch
    git checkout -b "$2";
    cd -;
}

commitandPushGitBranch() {
    # $1 : Local Git repo path
    # $2 : Branch Name
    cd $1;
    git add --all;
    git commit -m "Auto Commit - $(whoami)";
    git push origin "$2";
    cd -;
}

echo "Importing Functions"