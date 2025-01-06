*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Open Test Application    http://${APPIUM_HOST}:${APPIUM_PORT}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    app=${APP}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Suite Teardown    Close Test Application
Test Teardown     Take Screenshot On Failure

*** Variables ***
# Add Android specific locators here
${LOGIN_BUTTON}       id=com.example.testapp:id/loginButton
${USERNAME_FIELD}     id=com.example.testapp:id/usernameInput
${PASSWORD_FIELD}     id=com.example.testapp:id/passwordInput
${WELCOME_TEXT}       id=com.example.testapp:id/welcomeMessage

*** Test Cases ***
Should Launch Application Successfully
    Element Should Be Visible And Enabled    ${LOGIN_BUTTON}
    Page Should Contain Text    Welcome to Test App

Should Login Successfully
    Input Text Into Element          ${USERNAME_FIELD}    testuser
    Input Text Into Element          ${PASSWORD_FIELD}    password123
    Wait Until Element Is Visible And Click    ${LOGIN_BUTTON}
    Element Should Be Visible        ${WELCOME_TEXT}
    Element Should Contain Text      ${WELCOME_TEXT}    Welcome testuser 