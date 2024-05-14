*** Settings ***
Library     SeleniumLibrary
Library     String

*** Variables ***
${URL}      https://www.7eleven.co.th/login#

*** Keywords ***
setDefualtPage
    set window size    1920    1080

Login
    [Arguments]
    ...    ${input-email}
    ...    ${email-for-login}
    ...    ${input-password}
    ...    ${password-for-login}
    ...    ${time-out}=30s
    Open Browser    ${URL}    browser=chrome
    Wait Until Page Contains Element
    ...    xpath=//input[@name="${input-email}" and @type="email"]
    ...    timeout=${time-out}
    ...    error=XPath = data-testid ${input-email} not found
    Input Text    xpath=//input[@name="${input-email}" and @type="email"]    ${email-for-login}
    Wait Until Page Contains Element
    ...    xpath=//input[@name="${input-password}" and @type="password"]
    ...    timeout=${time-out}
    ...    error=XPath = data-testid ${input-password} not found
    Input Text    xpath=//input[@name="${input-password}" and @type="password"]    ${password-for-login}
    Wait Until Page Contains Element
    ...    xpath=//a[@class="btn btn-small"]
    ...    timeout=${time-out}
    ...    error=XPath = button a[@class="btn btn-small"] not found
    Click Element    xpath=//a[@class="btn btn-small"]
    ${text-title}=    Get Title
    Run Keyword If    '${text-title}' == 'Success'
    ...    Check return status is success    ${text-title}
    ...    ELSE IF    '${text-title}' == 'เข้าสู่ระบบ'
    ...    Check return status is fail    ${text-title}
    ...    ELSE
    ...    Log    Reject and End testing

Check return status is success
    [Arguments]    ${text-title-for-log}    ${time-out}=30s
    Log    Title: ${text-title-for-log}
    Wait Until Page Contains Element
    ...    xpath=//h1[@class="text-blue"]
    ...    timeout=${time-out}
    ...    error=XPath = h1[@class="text-blue"] not found
    Log    Login Success

Check return status is fail
    [Arguments]    ${text-title}    ${time-out}=30s
    Log    Title: ${text-title}
    Wait Until Page Contains Element
    ...    xpath=//p[@class="modal__key"]
    ...    timeout=${time-out}
    ...    error=XPath = p[@class="modal__key"] not found
    ${span-model}    Get Text    xpath=//p[@class="modal__key"]
    Run Keyword If    '${span-model}' == 'กรุณาตรวจสอบอีเมลอีกครั้งหรือลงทะเบียน 7Web ก่อนเข้าใช้งาน'
    ...    Wait Until Page Contains Element
    ...    xpath=//a[@class="modal__link"]
    ...    timeout=${time-out}
    ...    error=XPath = a[@class="modal__link"] not found
    Click Element    xpath=//a[@class="modal__link"]