*** Settings ***
Library           SSHLibrary
Library           DateTime

*** Variables ***
${SSH_KEYFILE}    %{HOME}/.ssh/id_ecdsa
${JOURNAL_SINCE}    0

*** Keywords ***
Connect to the node
    Open Connection   ${NODE_ADDR}
    Login With Public Key    root    ${SSH_KEYFILE}

Wait until boot completes
    ${output} =    Execute Command    systemctl is-system-running  --wait
    Should Be True    '${output}' == 'running' or '${output}' == 'degraded'

Save the journal begin timestamp
    ${tsnow} =    Get Current Date    result_format=epoch
    Set Global Variable    ${JOURNAL_SINCE}    ${tsnow}

Collect the suite journal
    Execute Command    printf "Test suite starts at %s\n" "$(date -d @${JOURNAL_SINCE})" >journal-dump.log
    Execute Command    journalctl >>journal-dump.log
    Get File    journal-dump.log    ${OUTPUT DIR}/journal-${SUITE NAME}.log

Disable systemd-resolved stub resolver
    Execute Command    printf '[Resolve]\nDNSStubListener=no\n' > /etc/systemd/resolved.conf.d/disable-stub.conf && systemctl try-restart systemd-resolved || :

*** Settings ***
Suite Setup       Run Keywords
                  ...    Connect to the Node
                  ...    Wait until boot completes
                  ...    Save the journal begin timestamp
                  ...    Disable systemd-resolved stub resolver

Suite Teardown    Run Keywords
                  ...    Collect the suite journal
