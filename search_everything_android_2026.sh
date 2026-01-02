#!/bin/bash
#Author: Alex Terranova 2024
#TITLE: Search All Android Termux
response=''
local char=""
local timeout=1
RED='\e[38;5;111m'
YEG='\e[38;5;190m'
REG='\033[0;0m'
DP='\e[38;5;162m'
extensions="\.([^.]*)$"
"\\.(gz|tgz)$"
IMAGES=".*\.(jpg|jpeg|gif|png|raw|dng|heic|bmp|svg|tiff|svgz|tif)$"
ALL="\.([^.]*)$"
VIDEO=".*\.(mov|mp4|mkv|avi|divx|wmv|vob|m3u8|ts)$"
DOCS=".*\.(rtf|doc|docx|odt|txt|md|xml|json|js|html|php|py|pl|css|exe|sh|pdf|csv|xml|torrent|xls|ppt|epub|cbr|cbz)$"
AUDIO=".*\.(ape|flac|alac|mp3|wav|ogg|aac|aiff|m3u|pls|opus)$"
ARCHIVES=".*\.(rar|tar|gz|7z|zip|zstd|gzip|bzip2|xz|cab|iso|jar|whl|cue|bin)$"
#while ! [[ $response = "q" ]]
#do
# Dynamically determine the F1 key's terminal code using tput
F1_CODE=$(tput kf1 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F1_CODE=${F1_CODE#^\[}
# Dynamically determine the F1 key's terminal code using tput
F2_CODE=$(tput kf2 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F2_CODE=${F2_CODE#^\[}
# Dynamically determine the F1 key's terminal code using tput
F3_CODE=$(tput kf3 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F3_CODE=${F3_CODE#^\[}
# Dynamically determine the F1 key's terminal code using tput
F4_CODE=$(tput kf4 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F4_CODE=${F4_CODE#^\[}
# Dynamically determine the F1 key's terminal code using tput
F5_CODE=$(tput kf5 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F5_CODE=${F5_CODE#^\[}
# Dynamically determine the F1 key's terminal code using tput
F6_CODE=$(tput kf6 | cat -A)
# Remove the leading '^[' (which is the escape character \e)
F6_CODE=${F6_CODE#^\[}
normal=1
DB=()
DBint=()
DBext=()
holdata=''
mykeyword=''
result=''
mode="All Files"
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
#if [[ "${URL}" =~ [^A-Za-z0-9] ]]; then
stop_spinner

echo -e "\t${YEG}Updated! ${REG}> ${REG}$response${REG}\n\n"
#echo -e "${InternalOut[@]}\n\n" 
#echo -e "${ExternalOut[@]}\n\n"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "Time taken: ${ELAPSED_TIME} Seconds"
#printf '%.s─' $(seq 1 $(tput cols)) 
echo ""
}
searcheverything
#while [ "$holddata" != "q" ]; do
 
while [[ "$holddata" != "." ]]; do
  echo -e "Enter another character: \n\n'.' to Quit \n',' to Update \n'*' All \n'@' Images \n'#' Audio \n'$' Video \n'%' Docs \n'^' Archives \n'&' to Confirm search"

   
   
   read -n 1 -s -r holddata

 
printf "\033c"  
   if [ "$holddata" == "*" ]; then
   extensions=""
   extensions=$ALL
   mode="All Files"
   fi
   if [ "$holddata" == "@" ]; then
   extensions=""
   extensions=$IMAGES
   mode="Images"
   fi
   if [ "$holddata" == "#" ]; then
   extensions=""
   extensions=$AUDIO
   mode="Audio"
   fi
   if [ "$holddata" == "$" ]; then
   extensions=""
   extensions=$VIDEO
   mode="Videos"
   fi
   if [ "$holddata" == "%" ]; then
   extensions=""
   extensions=$DOCS
   mode="Documents"
   fi
   if [ "$holddata" == "^" ]; then
   extensions=""
   extensions=$ARCHIVES
   mode="Archives"
   fi
   
   if [[ "$holddata" != $'\x7f' && "$holddata" != $'\x08' && "$holddata" =~ [[:alnum:]] ]]; then
  result+="$holddata"
  fi
  if [[ "$holddata" == $'\x7f' || "$holddata" == $'\x08' ]]; then
  if [ "${#result}" -gt 0 ]; then
  result="${result::-1}"
  fi
  fi
  
  
#read -p ' > ' holddata
#printf "\033c"
if [[ "$holddata" == "." ]]; then
exit 0
fi
if [[ "$holddata" == "," ]]; then
#result="${result::-1}"
searcheverything
fi

function getresults {
  
matching_files=()

# 4. Iterate through the array and apply the regex filter
for file in "${DBint[@]}"; do
  # Check if the current file name matches the regex pattern
  if [[ "$file" =~ $extensions ]]; then
    # Add the matching file to the results array
    matching_files+=("$file")
  fi
done


mapfile -t myresults < <(printf "%s\n" "${matching_files[@]}" | grep --color='always' -i "$result")
for line in "${myresults[@]}"; do
    echo "${line}"
done
echo -e "\n#Matches: ${#myresults[@]}"
}

if [[ "$holddata" != "." && "$holddata" != "," && "${#result}" -gt 2 && "$holddata" == "&" ]]; then

getresults
fi
if [[ "${#result}" -gt 0 ]]; then
echo ' '
echo "Search Mode: $mode"
echo ""
echo "You entered: $result"
echo ''
fi
#printf "\033c"
done
#done