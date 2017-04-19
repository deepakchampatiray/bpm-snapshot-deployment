#!/bin/bash

source "${BASH_SOURCE%/*}/constants.sh"
source "${BASH_SOURCE%/*}/functions.sh"

echo "WSADMIN PATH: $WSADMIN_PATH"

## Need arguments like 
##	Name of the Process App => --p_app
##	Name of the Snapshot => --snap
##	Username to execute WSADMIN scripts => --user
##	Password => --password
while [ $# -gt 0 ]; do
  case "$1" in
    --p_app=*)
      p_app="${1#*=}"
      ;;
    --snap=*)
      snap="${1#*=}"
      ;;
	--user=*)
      user="${1#*=}"
      ;;
	--password=*)
      password="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
	  printf "Usage: ./master.sh --p_app=<PROCESS APP ACRONYM> --snap=<SNAPSHOT NAME> --user=<ADMIN USER NAME> --password=<ADMIN USER PASSWORD> \n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if   [ -z "$p_app" ] || 
	 [ -z "$snap" ] || 
	 [ -z "$user" ] || 
	 [ -z "$password" ] 
then
	printf "***************************\n"
	printf "* Error: Invalid argument.*\n"
	printf "Usage: ./master.sh --p_app=<PROCESS APP ACRONYM> --snap=<SNAPSHOT NAME> --user=<ADMIN USER NAME> --password=<ADMIN USER PASSWORD> \n"
	printf "***************************\n"
	exit 1
fi

echo "Process App:" $p_app
echo "Snapshot:" $snap
echo "Username:" $user
echo "Password: *****"

# Create file to pull process-app details
buildPAFromTemplate "showPA.py" "$p_app";
# execute file to pull process-app details
echo 'Fetching Process Application details';
executePyInWsadmin $user $password "showPA.py";
# Parse WSadmin output to get Track Acronym
trackAckronym="$(python $SCRIPTS_DIR/readTrackInfo.py $snap)"
echo "Track Acronym: $trackAckronym"
# Parse WSadmin output to get Snopshot Acronym
snapshotAckronym="$(python $SCRIPTS_DIR/readSnapshotInfo.py $snap)"
echo "Snapshot Ackronym: $snapshotAckronym"
UNIQUE_FILE_NAME="$p_app.$trackAckronym.$snap";
echo "Unique Name: $UNIQUE_FILE_NAME"
# Create file to export process-app
buildPAExportFromTemplate "exportPA.py" "$p_app" "$snapshotAckronym" "$trackAckronym" "$WINDOWS_BASE_PATH\\\\scripts\\\\temp\\\\$UNIQUE_FILE_NAME.zip";
# Fire command to export process-app
echo 'Exporting Process Application';
executePyInWsadmin $user $password "exportPA.py";
# Create a new GIT branch
echo "Creating new GIT branch : $trackAckronym";
createGitBranch "$LOCAL_GITREPO/$p_app" "$trackAckronym";
# Extract file to git repo
echo 'Extracting exported zip into local GIT repo';
source "${BASH_SOURCE%/*}/extractBPMExport.sh";
# Commit and push git branch
echo "Commit and push new GIT branch : $trackAckronym";
commitandPushGitBranch "$LOCAL_GITREPO/$p_app" "$trackAckronym" "$snap";

# Empty the temp directory
echo 'Removing temp files'
rm -- "$SCRIPTS_DIR"/temp/*;



if [ -z $trackAckronym ]
then
  echo "Track not found"
  exit 1
fi

#cmd "/C showPA.bat"