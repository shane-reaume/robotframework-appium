*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Create And Open Test Application
Suite Teardown    Close Test Application
Test Teardown     Take Screenshot On Failure

*** Variables ***
# API Demos app locators
${APP_BUTTON}             accessibility_id=App
${ACTIVITY_BUTTON}        accessibility_id=Activity
${CUSTOM_TITLE_BUTTON}    accessibility_id=Custom Title
${LEFT_TEXT_FIELD}        id=io.appium.android.apis:id/left_text_edit
${RIGHT_TEXT_FIELD}      id=io.appium.android.apis:id/right_text_edit
${CHANGE_LEFT}           id=io.appium.android.apis:id/left_text_button
${CHANGE_RIGHT}          id=io.appium.android.apis:id/right_text_button

*** Keywords ***
Create And Open Test Application
    ${capabilities}=    Create Dictionary
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=${AUTOMATION_NAME}
    ...    app=${APP}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    Open Test Application    http://${APPIUM_HOST}:${APPIUM_PORT}    ${capabilities}

*** Test Cases ***
Should Launch Application Successfully
    Wait Until Page Contains Element    ${APP_BUTTON}
    Page Should Contain Element    ${APP_BUTTON}

Should Navigate To Activity Demo
    Wait Until Element Is Visible And Click    ${APP_BUTTON}
    Wait Until Element Is Visible And Click    ${ACTIVITY_BUTTON}
    Wait Until Element Is Visible And Click    ${CUSTOM_TITLE_BUTTON}
    Page Should Contain Text    Left is best
    Page Should Contain Text    Right is always right

Should Change Custom Title Text
    Input Text Into Element    ${LEFT_TEXT_FIELD}    Hello
    Wait Until Element Is Visible And Click    ${CHANGE_LEFT}
    Input Text Into Element    ${RIGHT_TEXT_FIELD}    World
    Wait Until Element Is Visible And Click    ${CHANGE_RIGHT}
    Page Should Contain Text    Hello
    Page Should Contain Text    World 