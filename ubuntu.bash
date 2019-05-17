###########################################################################
## COPY FILES / DIRECTORIES FROM ONE SERVER TO ANOTHER
###########################################################################

## -R: RECURISVELY COPY ENTIRE DIRECTORIES
scp -r ${FILE_NAME} ${USERNAME}@${IP_ADDRESS}:${DESTINATION}
