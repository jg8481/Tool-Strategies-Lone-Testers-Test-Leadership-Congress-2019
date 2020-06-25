*** Settings ***
Documentation                 Security and penetration tests that will check a target application for possible vulnerabilities. Combines various tools found in Kali Linux with Docker and Robot Framework.
Resource                      ${EXECDIR}//Tests//Workshop-Part-Two//Resources//Security-And-Penetration-Test-Resources.robot

Suite Setup    Generate Nmap XML Target File And Start Metasploit Database
Suite Teardown    Clean Up Metasploit Files And Terminate Processes

*** Variables ***
${PATH}               ${EXECDIR}

*** Test Cases ***
KALI LINUX TEST 1 - Check that the expected ports are open after running a verbose Nmap port scan on the target URL.
    Run Verbose Nmap Scan On A Target
    [Tags]    Kali_Linux_Security_And_Penetration_Tests    Nmap_Scan_Tests

KALI LINUX TEST 2 - Check that the provided port and target URL do not have any vulnerabilities detected through the Nmap NSE scripts.
    Run Nmap Vulnerability Scan On A Specific Port And Target
    [Tags]    Kali_Linux_Security_And_Penetration_Tests    Nmap_Scan_Tests

KALI LINUX TEST 3 - Check that the target URL does not have any Server Message Block Version vulnerabilities after running a Metasploit scan.
    Run Metasploit Framework Server Message Block Version Vulnerability Scan On A Target
    [Tags]    Kali_Linux_Security_And_Penetration_Tests    Metasploit_Scan_Tests

KALI LINUX TEST 4 - Check that the target URL does not have any NAT Port Mapping Protocol vulnerabilities after running a Metasploit scan.
    Run Metasploit Framework NAT Port Mapping Protocol Vulnerability Scan On A Target
    [Tags]    Kali_Linux_Security_And_Penetration_Tests    Metasploit_Scan_Tests

KALI LINUX TEST 5 - Check that the target URL does not have any SQL injection vulnerabilities after running a Sqlmap scan using the Space2Comment Tamper Script option.
    Run Sqlmap Space2Comment Tamper Script On A Target
    [Tags]    Kali_Linux_Security_And_Penetration_Tests    Sqlmap_Scan_Tests

*** Keywords ***

Run Verbose Nmap Scan On A Target
    Run Nmap Scan With Arguments And Check Results    -v    nodegoat.herokuapp.com

Run Nmap Vulnerability Scan On A Specific Port And Target
    Run Nmap Vulnerability Scan With Arguments And Check Results    80    nodegoat.herokuapp.com

Run Metasploit Framework Server Message Block Version Vulnerability Scan On A Target
    Run Metasploit Framework With Arguments And Check Results    auxiliary/scanner/smb/smb_version    10    nodegoat.herokuapp.com

Run Metasploit Framework NAT Port Mapping Protocol Vulnerability Scan On A Target
    Run Target XML Metasploit Framework With Arguments And Check Results    auxiliary/scanner/natpmp/natpmp_portscan    10

Run Sqlmap Space2Comment Tamper Script On A Target
    Run Sqlmap Scan With Arguments And Check Results    space2comment    nodegoat.herokuapp.com



