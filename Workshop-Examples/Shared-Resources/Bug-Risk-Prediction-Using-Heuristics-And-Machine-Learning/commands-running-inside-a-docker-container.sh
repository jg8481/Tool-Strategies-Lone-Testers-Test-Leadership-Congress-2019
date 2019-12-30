#!/bin/bash


GIT_LOG_HISTORY_AMOUNT=500
export GIT_LOG_HISTORY_AMOUNT

rm -rf ./rfw/Target-GitHub-Repo
echo "The following GitHub Repo will be cloned and analyzed --> $TARGET_GITHUB_REPO_URL"
git clone "$TARGET_GITHUB_REPO_URL".git ./rfw/Target-GitHub-Repo &&
wait
echo 'This container started running on '$TIMESTAMP1
echo
echo
echo '================> Display the contents of this Google Bug Prediction Heuristic, and Git Commit Bug Risk Prediction Docker container <================'
echo 'For more details please view the following Google Engineering Tools blog --> http://google-engtools.blogspot.com/2011/12/bug-prediction-at-google.html'
echo
echo
cd /rfw/Target-GitHub-Repo
ls -l
pwd
echo
echo
echo '================> Bug Prediction Heuristic Output 1 : Search for hotspots with the word --fix-- in the Git Log <================'
echo
git log --since="$GIT_LOG_HISTORY_AMOUNT".weeks --name-only --grep='fix' --pretty=format: | sort | uniq | sort -nr
echo
echo '==================================================> End Of Bug Prediction Heuristic Output 1 <=================================================='
echo
echo
echo
echo
echo '================> Bug Prediction Heuristic Output 2 : Search for hotspots with the word --bug-- in the Git Log <================'
echo
git log --since="$GIT_LOG_HISTORY_AMOUNT".weeks --name-only --grep='bug' --pretty=format: | sort | uniq | sort -nr
echo
echo '==================================================> End Of Bug Prediction Heuristic Output 2 <=================================================='
echo
echo
echo
echo "The machine learning tool is being trained on this GitHub repo's Git Log Metadata (specifically data from git log, git diff and git blame)"
echo
gitrisky train
## Optional: You can comment out the gitrisk train command and attempt to re-use the provided gitrisky.model that I already created, but I'm not sure of the accuracy of this model if it's used in other completely different GitHub repos. Curious? Experiment and find out ^_^
echo
echo
echo
echo
echo '================> Git Commit Bug Risk Prediction Output 1 : Assign a bug risk score for hotspots with the word --fix-- in the Git Log <================'
echo
echo
for i in $(git log --since="$GIT_LOG_HISTORY_AMOUNT".weeks --grep='fix' --pretty=format:%h | sort | uniq -c | sort -nr | awk '{print $2}'); do
    echo
    echo
    echo '-------- Git Commit Bug Risk Prediction Model is creating a bug risk score for this Git Commit : '$i' --------'
    echo
    gitrisky predict -c $i
    echo
    git log -n 1 --pretty=format:%s $i
    #git log -n 1 --shortstat $i | grep -v 'Author'
    #git show $i | grep -v 'Author'
    #git log -n 1 --stat $i | grep -v 'Author'
    echo
    echo '---------------------------------------------------'
    echo
    echo
done
echo
echo
echo '==================================================> End Of Git Commit Bug Risk Prediction Output 1 <=================================================='
echo
echo
echo
echo
echo '================> Git Commit Bug Risk Prediction Output 2 : Assign a bug risk score for hotspots with the word --bug-- in the Git Log <================'
echo
echo
for i in $(git log --since="$GIT_LOG_HISTORY_AMOUNT".weeks --grep='bug' --pretty=format:%h | sort | uniq -c | sort -nr | awk '{print $2}'); do
    echo
    echo
    echo '-------- Git Commit Bug Risk Prediction Model is creating a bug risk score for this Git Commit : '$i' --------'
    echo
    gitrisky predict -c $i
    echo
    git log -n 1 --pretty=format:%s $i
    #git log -n 1 --shortstat $i | grep -v 'Author'
    #git show $i | grep -v 'Author'
    #git log -n 1 --stat $i | grep -v 'Author'
    echo
    echo '---------------------------------------------------'
    echo
    echo
done
echo
echo
echo '==================================================> End Of Git Commit Bug Risk Prediction Output 2 <=================================================='
echo
echo
echo
echo
TIMESTAMP2=$(date)
echo 'This container finished running on '$TIMESTAMP2
