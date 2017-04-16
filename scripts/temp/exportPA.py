print "Exporting Process Application"

#https://www.ibm.com/support/knowledgecenter/SSFTDH_8.5.7/com.ibm.wbpm.ref.doc/topics/rref_bpmexportinstallpackages.html

print AdminTask.BPMExportInstallPackage('[-containerAcronym CVS -containerSnapshotAcronym 041117C -containerTrackAcronym Main -outputFile "G:\Github\CVS\S_041117C_Snapshot1.zip"]')