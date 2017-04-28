# bpm-snapshot-deployment
How to automate snapshot deployment in BPM.

# Setup
Please follow the underlying steps to setup a new process-application.
  * Make sure that "wsadmin" scripts are installed and you have appropriate privileges to run the wsadmin scripts on the server where you are deploying this script.
  * Edit the function "executePyInWsadmin" in the file "/scripts/functions.sh" for the appropriate operating system (The original version assumes that Process-Center and wsadmin scripts are on a Windows machine).
  * Modify the value for "WINDOWS_BASE_PATH" in the file "/scripts/constants.sh" to reflect the directory where you have installed this automation script.
  * Modify the value for "USER_INSTALL_ROOT" in the file "/scripts/constants.sh" to reflect the root directory of your IBM BPM installation.
  * Within the "bin" directory of above "USER_INSTALL_ROOT" path there should be the wsadmin script (shell or bat).
  * Go into the _"USER_INSTALL_ROOT"/properties_ directory and edit the file _wsadmin.properties_ to set appropriate values for
    1. com.ibm.ws.scripting.connectionType : SOAP
    1. com.ibm.ws.scripting.port : To detrmine this value go to Websphere Console > WebSphere application server clusters > [CLUSTER NAME] > Local Topology > Drill Down to the  Cluster Mamber > Ports > SOAP_CONNECTOR_ADDRESS
    1. com.ibm.ws.scripting.host : Host name of the server to be used in the WSADMIN commands.
    1. com.ibm.ws.scripting.defaultLang : jython
  * Create a new empty git repository on your git server. Name of the repository should match that of the process-app acronym.
  * Clone the git repo into a directory on the same server where you are deploying this automation script. Note down the path of this local directory where the git repo was cloned into. This needs to go into the valus for "GIT_PATH" and "LOCAL_GITREPO" in the "/scripts/constants.sh" file.

> **Note** : This script creates a new git branch corresponding to the track of the process-app snapshot you are exporting. Name of the branch is same as the track acronym. Each new snapshot for that track gets commited on to the same branch (Created as per the name of the track).

# How to Use
**./master.sh --p_app=[PROCESS APP ACRONYM] --snap=[SNAPSHOT NAME] --user=[ADMIN USER NAME] --password=[ADMIN USER PASSWORD]**
