#!/bin/bash

######################################################################
# CONSTRUCTOR BLOCK - DECLARE VARIABLES & CONFIG OPTIONS
######################################################################

# RESET GETOPTS IN CASE SHELL HAS CALLED PREVIOUS GETOPTS
OPTIND=1 ;

# SCRIPT VARIABLES
SCRIPT=$( basename "${BASH_SOURCE[0]}" ) ; # SCRIPT NAME
SCRIPTPATH=$( cd "$(dirname "$0")" || exit ; pwd -P )  ; # ABSOLUTE PATH OF SCRIPT DIRECTORY
SCRIPTMOD=$( stat -c %Y "${SCRIPTPATH}"/"${SCRIPT}" ) ; # SCRIPT LAST MOD TIMESTAMP IN EPOCH
NUMARGS=$# ; # NUMBER OF ARGUMENTS PASS FROM CLI

# ENVIRONMENT VARIABLES
DIR_SUBLIME_SNIPPETS="${HOME}/.config/sublime-text-3/Packages/User/snippets";

# ASCII COLOR CODES
declare -A c ;
c[red]='\033[0;31m' ; # ERROR
c[yellow]='\033[0;33m' ; # IN PROCESS
c[green]='\033[0;32m' ; # SUCCESS
c[purple]='\033[0;35m' ; # NETWORK
c[blue]='\033[0;34m' ; # EXECUTABLE
c[cyan]='\033[36m' ; # EVENT
c[nc]='\033[0m' ; # RESET COLOR

###########################################################################
## HELP FUNCTION
###########################################################################

function HELP() {
  echo -e \\n"${c[cyan]}Help Documentation for ${SCRIPT}. ${c[nc]}"
  echo -e "${c[yellow]}Last Modified: $(date -d @${SCRIPTMOD}) ${c[nc]}"\\n
  echo -e "${c[cyan]}${SCRIPT} Recognizes the Following Flags: ${c[nc]}"\\n
  # LIST & DESCRIBE AVAILABLE ARGUMENTS
  echo -e "${c[yellow]}--example-flag ${c[nc]}      --Description for example flag"
  echo -e "${c[yellow]}--help ${c[nc]}              --Displays this Help Message. No Further Functions are Performed."\\n
}

# CHECK ARGUMENTS. IF NONE ARE PASSED, PRINT HELP & EXIT
if [ "${NUMARGS}" -eq 0 ] ; then
  HELP
fi

###########################################################################
## GENERATE FIXTURE FUNCTION
###########################################################################

function GENERATE_FIXTURE() {

read -rp 'What is the name of your fixture file? (example.json): ' FIXTURE_FILENAME
read -rp 'What is the name of your model? (website.Page): ' FIXTURE_MODEL

read -r -d '' FIXTURE_TEMPLATE <<EOF
{
    "model": "${FIXTURE_MODEL}",
    "pk": 1,
    "fields": {
        "product": ["victory-wave-air-force-flags"],
        "name": "Victory Wave Air Force Flag - Mini",
        "size": "Mini",
        "price": 40.00,
        "length": 12.5,
        "height": 6.5
    }
}
EOF

echo -n "${FIXTURE_TEMPLATE}"

# echo 'Please enter the fields necessary for your fixture'
# while true; do
#   read -rp 'Enter the field name for your fixture model (name): ' FIXTURE_MODEL_FIELD
#   read -rp  'Do you want to add another field to your fixture model? (y/n): ' -n 1 ## -N FLAG FOR NUMBER OF CHARACTERS ALLOWED
#   if [[ "${REPLY,,}" =~ ^(n) ]]; then ## ,, ON VARIABLE FOR LOWERCASE TRANFORM
#     echo -n 'Breaking while statement'
#     break
#   else
#     echo -n 'Continuing loop'
#   fi
# done


# echo "${FIXTURE_FILENAME}"
# echo "${FIXTURE_MODEL}"

# touch "${FIXTURE_FILENAME}"

# NAME='Home Page'
# SLUG='home-page'
# TITLE='Title'
# DESCRIPTION='Description'

# declare -a PAGES
# PAGES+=("Home Page")
# PAGES+=('About Page')


# for PAGE in ${PAGES[@]} ; do
#   echo -e "$PAGE"
# done

# echo -e "${PAGES[@]}"

}

######################################################################
# CONFIGURATION BLOCK - LOAD OPTIONS FROM COMMAND LINE
######################################################################

# SET FLAGS
while test $# -gt 0 ; do
  case "$1" in
    -gf|--generate-fixture ) GENERATE_FIXTURE ; shift ;;
    -h|--help ) HELP ; shift ;;
    -- ) shift ; break ;;
    * ) break ;;
  esac
done
