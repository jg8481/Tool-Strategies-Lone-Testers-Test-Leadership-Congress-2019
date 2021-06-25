*** Settings ***
Documentation                 Security and penetration tests that will check a target application for possible vulnerabilities. Combines OWASP Zap, Selenium, Docker and Robot Framework.
Resource                      ${EXECDIR}//Tests//Workshop-Part-Two//Resources//Security-And-Penetration-Test-Resources.robot

Suite Setup    Check OWASP Zap Proxy And XVFB Are Both Running
Suite Teardown    Generate Reports Gather Logs And Clean Up

*** Variables ***
${PATH}               ${EXECDIR}

*** Test Cases ***
OWASP ZAP TEST 1 : Checks for different types of Injection vulverabilities using the OWASP Zap Active Scanners.
    Run Active Scans For Number 1 Risk In 2020 OWASP Top 10
    [Tags]    OWASP_Zap_Security_And_Penetration_Tests    Number_1_Risk_On_OWASP_Top_10    Injection_Vulverability_Test

OWASP ZAP TEST 2 : Checks for different types of Cross-Site Scripting vulverabilities using the OWASP Zap Active Scanners.
    Run Active Scans For Number 7 Risk In 2020 OWASP Top 10
    [Tags]    OWASP_Zap_Security_And_Penetration_Tests    Number_7_Risk_On_OWASP_Top_10    Cross-Site_Scripting_Vulverability_Test

OWASP ZAP TEST 3 : Checks for Injection and Cross-Site Scripting using Selenium and OWASP Zap Passive and Active Scanners
    Run Combined Selenium Zap Scans For Number 1 and 7 Risks In 2020 OWASP Top 10
    [Tags]    OWASP_Zap_Security_And_Penetration_Tests    Number_1_Risk_On_OWASP_Top_10    Number_7_Risk_On_OWASP_Top_10    Injection_Vulverability_Test    Cross-Site_Scripting_Vulverability_Test

*** Keywords ***

Run Active Scans For Number 1 Risk In 2020 OWASP Top 10
    Run OWASP Zap Recursive Active Scan With Specific Settings Then Check Result    sqli    High    Low    https://nodegoat.herokuapp.com

Run Active Scans For Number 7 Risk In 2020 OWASP Top 10
    Run OWASP Zap Recursive Active Scan With Specific Settings Then Check Result    xss    High    Low    https://nodegoat.herokuapp.com

Run Combined Selenium Zap Scans For Number 1 and 7 Risks In 2020 OWASP Top 10
    Connect OWASP Zap Proxy With Firefox Browser    https://nodegoat.herokuapp.com
    Login In To Node Goat Vulnerable Website Wait For Passive Scan
    Run OWASP Zap Recursive Active Scan With Specific Settings Then Check Result    sqli    High    Low    https://nodegoat.herokuapp.com
    Run OWASP Zap Recursive Active Scan With Specific Settings Then Check Result    xss    High    Low    https://nodegoat.herokuapp.com

