#! /bin/bash

OWASP_ZAP_URL="http://$1:$2/"
OWASP_ZAP_URL+="JSON/pscan/view/recordsToScan/?"
OWASP_ZAP_URL+="zapapiformat=JSON&"
OWASP_ZAP_URL+="formMethod=GET&"
echo "OWASP URL check -> $OWASP_ZAP_URL"
CHECK_PASSIVE_SCANNER=0
until [ $CHECK_PASSIVE_SCANNER -eq 0 ]; do
    sleep 10
    OWASP_SCANNER_STATUS=$(curl -s $OWASP_ZAP_URL)
    CHECK_PASSIVE_SCANNER=$(echo $OWASP_SCANNER_STATUS | jq -r '.recordsToScan')
    echo "Passive scanner is currently in progress at $CHECK_PASSIVE_SCANNER%"
done
echo "Passive scanner is finished running"

