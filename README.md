# bpm-snapshot-deployment
How to automate snapshot deployment in BPM

# Steps
Gather the following inputs from user and store it in variables as shown
  * Process App Acronym => PROC_APP
  * Full Snapshot Name to be deployed => SNAP
  * Source Environment (Process Center) => PC_ENV

Use the value in **PC_ENV** to calculate the following values, these will be used as parameters while firing the *wsadmin* command. These should be placed in the "env" directory under an appropriately named file corresponding to the given Process-Center node.
  * hostname for a node that has the process-center running. Please use the hostname for the actual node and not the deployment manager.
  * SOAP port for the node. You can find this from the Websphere console Servers > Clusters > Websphere application server clusters > [CLUSTER NAME] > Local Topology > [DRILL DOWN TO THE TARGET CLUSTER MEMBER] > Communications > Ports > [NOTE THE VALUE FOR SOAP_CONNECTOR_ADDRESS]
  * Connection type. Using "SOAP" for this application.
  * Script Language. Using "jython".
