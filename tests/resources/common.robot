*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${TIMEOUT}              30
${RETRY_INTERVAL}       2

*** Keywords ***
Open Test Application
    [Arguments]    ${remote_url}    ${capabilities}
    Open Application    ${remote_url}    &{capabilities}
    Set Appium Timeout    ${TIMEOUT}

Close Test Application
    Close Application

Wait Until Element Is Visible And Click
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}

Input Text Into Element
    [Arguments]    ${locator}    ${text}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Input Text    ${locator}    ${text}

Element Should Be Visible And Enabled
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Element Should Be Enabled    ${locator}

Take Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot 