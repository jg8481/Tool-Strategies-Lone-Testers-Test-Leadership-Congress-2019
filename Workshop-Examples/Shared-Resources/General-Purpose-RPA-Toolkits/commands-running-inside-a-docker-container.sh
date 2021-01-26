#!/bin/bash



cd /rfw
envsubst < ./Tasks/Crypto-Mining-Machines-Checker/template.slacktee > ./Tasks/Crypto-Mining-Machines-Checker/.slacktee
pabot --verbose --rpa --include "$1" --report NONE --output crypto-machine-checker-output.xml --log crypto-machine-checker-results.html -N "Robot Framework task runner - Checking crypto mining machine" -d ./Results ./Tasks/Crypto-Mining-Machines-Checker
