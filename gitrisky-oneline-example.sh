#! /bin/bash
clear
echo
read -p "Please provide a full path to the cloned Git repo: " REPO_PATH
echo
echo "Please provide the amount of weeks you would like to filter in the git logs."
echo "For example, enter the number 2 to see git logs for the past two weeks."
read -p "Enter a larger number if nothing is displayed: " AMOUNT
echo
#The following single line of Shell does most of the work. It feeds the gitrisky tool the git log metadata containing the word "fix".
cd "$REPO_PATH" && for i in $(git log --since="$AMOUNT".weeks --grep='fix' --pretty=format:%h | uniq -c | awk '{print $2}'); do echo && gitrisky train > /dev/null 2>&1 && gitrisky predict -c $i && git log -n 1 --shortstat $i | grep -v 'Author'; done
echo
