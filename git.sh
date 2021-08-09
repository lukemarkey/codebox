## LIST ALL COMMITS FOR THE PROJET
git log

## RESET INDEX TO FORMER COMMIT
git reset ${COMMIT_ID}

## MOVE POINTER BACK TO PREVIOUS HEAD
git reset --soft HEAD@{1}
git commit -m 'Revert to Another Commit'

## UPDATE WORKING COPY TO REFLECT LATEST COMMIT
git reset --hard

## RUN SSH-AGENT
eval $(ssh-agent -s)