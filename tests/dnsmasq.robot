*** Settings ***
Library    SSHLibrary
Library    DnsmasqTest.py

*** Variables ***
${INTERFACE}    eth0
${FIRST_ADDR}   192.168.0.1
${LAST_ADDR}    192.168.0.254
${SCENARIO}     install

*** Test Cases ***
Module installation
    [Tags]    create
    IF    r'${SCENARIO}' == 'update'
        Set Local Variable  ${iurl}  dnsmasq
    ELSE
        Set Local Variable  ${iurl}  ${IMAGE_URL}
    END
    ${output}  ${rc} =    Execute Command    add-module ${iurl} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{output} =    Evaluate    ${output}
    Set Global Variable    ${MID}    ${output.module_id}

Configure module
    &{output} =    Run task    module/${MID}/get-available-interfaces  {}
    Set Global Variable    ${INTERFACE}  ${output}[data][0][name]
    ${first}  ${last} =     GetDhcpRange  ${output}[data][0][network]
    Set Global Variable  ${FIRST_ADDR}  ${first}
    Set Global Variable  ${LAST_ADDR}  ${last}
    Run task    module/${MID}/configure-module  {"interface":"${INTERFACE}","dhcp-server":{"enabled":true,"start":"${FIRST_ADDR}","end":"${LAST_ADDR}","lease":4,"gateway":"${FIRST_ADDR}"},"dns-server":{"enabled":true,"primary-server":"8.8.4.4","secondary-server":"8.8.8.8"}}

Check module update
    [Tags]    create
    Log  Scenario ${SCENARIO} with ${IMAGE_URL}  console=${True}
    IF    r'${SCENARIO}' == 'update'
        ${out}  ${rc} =  Execute Command  api-cli run update-module --data '{"force":true,"module_url":"${IMAGE_URL}","instances":["${MID}"]}'  return_rc=${True}
        Should Be Equal As Integers  ${rc}  0  action update-module ${IMAGE_URL} failed
    END

Check DNSmasq config
    ${out}  ${err}  ${rc} =  Execute Command    while ! podman container exists ${MID} ; do sleep 0.3 ; done ; podman exec ${MID} dnsmasq --test
    ...    return_rc=True    return_stderr=True    timeout=5s
    Should Be Equal As Integers    ${rc}  0

Check DNS service
    ${out}  ${err}  ${rc} =  Execute Command    ss -lunp | grep ':53'
    ...    return_rc=True    return_stderr=True
    Should Be Equal As Integers    ${rc}  0

Check DHCP service
    ${out}  ${err}  ${rc} =  Execute Command    ss -lunp | grep ':67'
    ...    return_rc=True    return_stderr=True
    Should Be Equal As Integers    ${rc}  0


Check module removal
    [Tags]    remove
    ${out}  ${err}  ${rc} =  Execute Command    remove-module --no-preserve ${MID}
    ...    return_rc=True    return_stderr=True
    Should Be Equal As Integers    ${rc}  0


*** Keywords ***
Run task
    [Arguments]    ${action}    ${input}    ${decode_json}=${TRUE}    ${rc_expected}=0
    ${stdout}    ${stderr}    ${rc} =     Execute Command    api-cli run ${action} --data '${input}'    return_stdout=True    return_stderr=True    return_rc=True
    Should Be Equal As Integers    ${rc_expected}    ${rc}    Run task ${action} failed!${\n}${stderr}
    IF    ${decode_json} and len($stdout) > 0
        ${response} =    Evaluate    json.loads('''${stdout}''')    modules=json
    ELSE
        ${response} =    Set Variable    ${stdout}
    END
    RETURN    ${response}
