#!/bin/bash
#Author: Alex Terranova 2024
#TITLE: Search All Android Termux
response=''
RED='\e[38;5;111m'
YEG='\e[38;5;190m'
REG='\033[0;0m'
DP='\e[38;5;162m'
pictures=0
normal=0
videos=0
documents=0
music=0
executables=0
archives=0
#while ! [[ $response = "q" ]]
#do
pictures=0
normal=1
videos=0
documents=0
executables=0
music=0
archives=0
DB=()
DBint=()
DBext=()
holdata=''

#echo -e "\n${YEG}Find What?${REG}"
#read -p '> ' response
#echo ''
#printf "\033c"
printf "\033c"
function searcheverything() {
START_TIME=$SECONDS


#oifs="$IFS"  ## save original IFS
#IFS=$'\n'    ## set IFS to break on newline


function start_spinner {
    set +m
    echo -n "$1"
    { while : ; do for X in 'Updating     ' 'Updating.    ' 'Updating..   ' 'Updating...  ' 'Updating.... ' 'Updating.....'; do echo -en "\r$X" ; sleep 0.1 ; done ; done & } 2>/dev/null



spinner_pid=$!
}

function stop_spinner {
    { kill -9 $spinner_pid && wait; } 2>/dev/null
    set -m
    echo -en "\033[2K\r"
}

spinner_pid=
start_spinner ""


cd ~/storage
string="$(ls -la -l 2>&1)"
if [[ "$string" == *"external-1"* ]]; then
searchstringbefore=$(ls -la | grep -m1 -oP '[A-Z0-9+\-]{9}' )
sdcardpath="/storage/$searchstringbefore"
internalpath="/storage/emulated/0"
fi
if [ $normal = 1 ]; then

function iterate() {
  local dir="$1"

  for file in "$dir"/*; do
    if [ -f "$file" ]; then
      echo "$file"
    fi

    if [ -d "$file" ]; then
      iterate "$file"
    fi
  done
}


while IFS=  read -r -d $'\0'; do
    DBint+=("$REPLY")
done < <(find "$sdcardpath" -type f -print0 2> /dev/null)

while IFS=  read -r -d $'\0'; do
    DBint+=("$REPLY")
done < <(find "$internalpath" -type f -print0 2> /dev/null)


#DBint=($(iterate "$sdcardpath"))
#DBext=($(iterate "$internalpath"))

DBint+=("${DBext[@]}")
#IFS="$oifs"  

#DB=( "${DB[@]// /_}" )
#DB=( "${DB[@]// /_}" )
#DB=( "${DB[@]//-/_}" )
#DB=("${DB[@]//[\[\]]/}")
#DB=("${DB[@]//[\(\)]/}")
#DB=("${DB[@]/./}")

#echo "$new_string" # Output: filetxt

fi

#

stop_spinner

echo -e "\t${YEG}Updated! ${REG}> ${REG}$response${REG}\n\n"
#echo -e "${InternalOut[@]}\n\n" 
#echo -e "${ExternalOut[@]}\n\n"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "Time taken: ${ELAPSED_TIME} Seconds"
#printf '%.s─' $(seq 1 $(tput cols)) 
}
searcheverything
while [ "$holddata" != "q" ]; do
echo -e "\n${YEG}[q] = Quit [u] = Update\n > Find What?${REG}"
read -p ' > ' holddata
printf "\033c"
if [[ "$holddata" == "q" ]]; then
exit 0
fi
if [[ "$holddata" == "u" ]]; then
searcheverything
fi

function getresults {
printf "%s\n" "${DBint[@]}" | grep --color='auto' -i "$holddata"
echo ' '

echo "You entered: $holddata"
echo ''
}

if [[ "$holddata" != "u" && "$holddata" != "q" ]]; then
getresults
fi
#printf "\033c"
done
#done