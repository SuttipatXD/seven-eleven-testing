*** Settings ***
Resource        ./resource.robot

*** Test Cases ***

01-Login-email-format-is-wrong
    [Tags]    login
    ${email-random}    Generate Random String  4  [LETTERS]
    Log    email random: ${email-random}
    ${password-random}    Generate Random String  8  [LETTERS]
    Log    password random: ${password-random}
    Login    email     ${email-random}     password     ${password-random}

02-Login-password-format-is-wrong
    [Tags]    login
    ${email-random}    Generate Random String  4  [LETTERS]
    Log    email random: ${email-random}@gmail.com 
    ${password-random}    Generate Random String  5  [LETTERS]
    Log    password random: ${password-random}
    Login    email     ${email-random}@gmail.com      password     ${password-random}    2

03-Login-email-is-wrong
    [Tags]    login
    ${email-random}    Generate Random String  4  [LETTERS]
    Log    email random: ${email-random}@gmail.com
    ${password-random}    Generate Random String  8  [LETTERS]
    Log    password random: ${password-random}
    Login    email     ${email-random}@gmail.com     password     ${password-random}

04-Login-success
    [Tags]    login-success
    Login    email     sajotod286@bsomek.com     password     J3d*E0i4G    