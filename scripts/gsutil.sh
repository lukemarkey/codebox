###########################################################################
## GOOGLE CLOUD STORAGE CLI
###########################################################################

curl https://sdk.cloud.google.com | bash
## CLOSE TERMINAL AND START NEW SESSION
gcloud init
gsutil cp ${LOCAL_FILE} gs://${BUCKET_NAME}/
