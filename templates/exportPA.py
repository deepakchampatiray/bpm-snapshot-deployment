print "Exporting Process Application"

#https://www.ibm.com/support/knowledgecenter/SSFTDH_8.5.7/com.ibm.wbpm.ref.doc/topics/rref_bpmexportinstallpackages.html

print AdminTask.BPMExportInstallPackage('[-containerAcronym <<PROCESS_APP_ACRONYM>> -containerSnapshotAcronym <<SNAPSHOT_ACRONYM>> -containerTrackAcronym <<TRACK_ACRONYM>> -outputFile "<<OUTPUT_FILE_PATH>>"]')