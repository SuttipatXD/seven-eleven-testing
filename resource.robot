*** Settings ***
Library     SeleniumLibrary
Library     String


*** Variables ***
${URL}      https://www.7eleven.co.th/login#


*** Keywords ***
setDefualtPage
    set window size    1920    1080

Login
    [Documentation]    Keyword นี้จะถูกเรียกใช้เมื่อต้องการทดสอบการ Login
    [Arguments]
    ...    ${input-email}
    ...    ${email-for-login}
    ...    ${input-password}
    ...    ${password-for-login}
    ...    ${index-span}=1
    ...    ${time-out}=30s
    Open Browser    ${URL}    browser=chrome
    setDefualtPage
    Wait Until Page Contains Element
    ...    xpath=//input[@name="${input-email}" and @type="email"]
    ...    timeout=${time-out}
    ...    error=XPath = data-testid ${input-email} not found.
    Input Text    xpath=//input[@name="${input-email}" and @type="email"]    ${email-for-login}
    Wait Until Page Contains Element
    ...    xpath=//input[@name="${input-password}" and @type="password"]
    ...    timeout=${time-out}
    ...    error=XPath = data-testid ${input-password} not found.
    Input Text    xpath=//input[@name="${input-password}" and @type="password"]    ${password-for-login}
    Wait Until Page Contains Element
    ...    xpath=//a[@class="btn btn-small"]
    ...    timeout=${time-out}
    ...    error=XPath = button a[@class="btn btn-small"] not found.
    Click Element    xpath=//a[@class="btn btn-small"]
    Sleep    5
    ${text-title}=    Get Title
    IF    '${text-title}' == 'Success'
        Check return status is success
    ELSE IF    '${text-title}' == 'เข้าสู่ระบบ'
        Check return status is fail    ${index-span}
    ELSE
        Log    Reject and End testing.
    END

Check return status is success
    [Documentation]    Keyword นี้จะถูกเรียกใช้เมื่อ title เป็น Success
    [Arguments]    ${time-out}=30s
    Wait Until Page Contains Element
    ...    xpath=//h1[@class="text-blue"]
    ...    timeout=${time-out}
    ...    error=XPath = h1[@class="text-blue"] not found.
    Log    Login Success
    Close Browser

Check return status is fail
    [Documentation]    Keyword นี้จะถูกเรียกใช้เมื่อ title เป็น เข้าสู่ระบบ
    [Arguments]    ${index-span}    ${time-out}=30s

    Run Keyword If    ${index-span} == '1'
    ...    Wait Until Page Contains Element
    ...    xpath=//span[${index-span}][@class="forgot-password"]
    ...    timeout=${time-out}
    ...    error=XPath = span[${index-span}][@class="forgot-password"] not found.
    ${span-mail-error}=    Get Text    xpath=//span[${index-span}][@class="forgot-password"]
    Log    msg: ${span-mail-error}
    Run Keyword If     '${span-mail-error}' == 'อีเมลล์ไม่ถูกต้อง'
    ...    Handle Element Found    email
    ...    ELSE IF    '${span-mail-error}' == 'รหัสผ่าน (ต้องมีความยาว 6 - 15 ตัวอักษร )'
    ...    Handle Element Found    password
    ...    ELSE
    ...    Handle Element Not Found

Handle Element Found
    [Documentation]    Keyword นี้จะถูกเรียกใช้เมื่อพบ error เป็น อีเมลล์ไม่ถูกต้อง 
    [Arguments]    ${type-error}
    Log    error: ${type-error} format is wrong.
    Close Browser

Handle Element Not Found
    [Documentation]    Keyword นี้จะถูกเรียกใช้เมื่อไม่พบ error
    [Arguments]    ${time-out}=30s
    Wait Until Page Contains Element
    ...    xpath=//p[@class="modal__key"]
    ...    timeout=${time-out}
    ...    error=XPath = p[@class="modal__key"] not found.
    ${span-model}=    Get Text    xpath=//p[@class="modal__key"]
    Log    msg: ${span-model}
    Wait Until Page Contains Element
    ...    xpath=//a[@class="modal__link"]
    ...    timeout=${time-out}
    ...    error=XPath = a[@class="modal__link"] not found.
    Click Element    xpath=//a[@class="modal__link"]
    Close Browser