###########################################################################
## AWS GLACIER
###########################################################################

## UPLOAD FILE TO AWS GLACIER

aws glacier upload-archive --account-id ${ACCOUNT_ID} --archive-description ${DESCRIPTION} --vault-name ${VAULT_NAME} --body ${FILE}

## LIST PENDING AND COMPLETED JOBS FOR AWS GLACIER VAULT

aws glacier list-jobs --account-id ${ACCOUNT_ID} --vault-name ${VAULT_NAME}
aws glacier list-multipart-uploads --account-id - --vault-name ${VAULT_NAME}

## LIST / GET ARCHIVES WITHIN AWS GLACIER VAULT

aws glacier initiate-job --account-id ${ACCOUNT_ID} --vault-name ${VAULT_NAME} --job-parameters '{"Type": "inventory-retrieval"}'

## GET JOB OUTPUT FOR AWS GLACIER

aws glacier get-job-output --account-id ${ACCOUNT_ID} --vault-name ${VAULT_NAME} --job-id ${JOB_ID} output.json


## MULTIPART UPLOAD (EDIT SCRIPT FOR VAULT NAME)

wget https://raw.githubusercontent.com/benporter/aws-glacier-multipart-upload/master/glacierupload.sh
chmod u+x glacierupload.sh
split --bytes=4194304 --verbose ${ZIPFILE} part
./glacierupload.sh

###########################################################################
## AWS GLACIER ACCESS POLICY
###########################################################################

{
    "Version":"2012-10-17",
    "Statement":[
    {
      "Sid":"cross-account-upload",
      "Principal": {
         "AWS": [
         "${AWS_USER_ID}"
         ]
     },
     "Effect":"Allow",
     "Action": [
     "glacier:UploadArchive",
     "glacier:InitiateMultipartUpload",
     "glacier:AbortMultipartUpload",
     "glacier:CompleteMultipartUpload"
     ],
     "Resource": [
     "${AWS_RESOURCE_ID}"
     ]
 }
 ]
}

###########################################################################
## AWS GLACIER VAULT LOCK POLICY
###########################################################################

{
 "Version":"2012-10-17",
 "Statement":[
 {
     "Sid": "deny-based-on-archive-age",
     "Principal": "*",
     "Effect": "Deny",
     "Action": "glacier:DeleteArchive",
     "Resource": [
     "${AWS_RESOURCE_ID}"
     ],
     "Condition": {
         "NumericLessThan" : {
          "glacier:ArchiveAgeInDays" : "365"
      }
  }
}
]
}

###########################################################################
## AWS S3
###########################################################################

## SYNC AWS S3 BUCKET TO LOCAL DIRECTORY
aws s3 sync s3://${S3_BUCKET_NAME} ${LOCAL_DIRECTORY}

## LIST ALL MULTIPART UPLOADS IN BUCKET
aws s3api list-multipart-uploads --bucket ${BUCKET}

###########################################################################
## AWS S3 BUCKET POLICY
###########################################################################

{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "AddPerm",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${S3_BUCKET_NAME}/*"
    }
    ]
}

{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "AddPerm",
        "Effect": "Deny",
        "NotPrincipal": {
          "AWS": [
            "arn:aws:iam::416074996998:user/luke",
            "arn:aws:iam::416074996998:root"
          ]
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:us-east-1:416074996998:domain/elasticsearch"
  }
}

###########################################################################
## AWS POLICY ALLOW ACCESS FROM SPECIFIC IP ADDRESS
###########################################################################

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "es:*"
      ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "76.97.68.93/32"
          ]
        }
      },
      "Resource": "arn:aws:es:us-east-1:416074996998:domain/elasticsearch/*"
    }
  ]
}
