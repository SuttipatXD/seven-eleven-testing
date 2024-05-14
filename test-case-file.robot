*** Settings ***
Resource        ./resource.robot

*** Test Cases ***

01-Login-email-is-wrong
    [Tags]    login
    ${email-random}    Generate Random String  4  [LETTERS]
    Log    email random: ${email-random}@gmail.com
    ${password-random}    Generate Random String  8  [LETTERS]
    Log    password random: ${password-random}
    Login    email     ${email-random}@gmail.com     password     ${password-random}

02-Login-success
    [Tags]    login
    Login    email     sajotod286@bsomek.com     password     J3d*E0i4G