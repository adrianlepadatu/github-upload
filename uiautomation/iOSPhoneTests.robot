*** Settings ***
Suite Setup
Test Setup
Library           AppiumLibrary
Library           String
Library           OperatingSystem
Resource          Functions/Android/General.robot
Resource          Variables.robot
Library           ./Util.py

*** Variables ***

   ${APPIUM_SERVER1}       http://0.0.0.0:4723/wd/hub
   ${APPIUM_SERVER2}       http://0.0.0.0:4750/wd/hub
${destdevice}    Muthabor iPhone8
${app}    com.orange.labs.cinderella       #find package name of your app
${version}    version=11.1.2
${platform}    iOS
${deviceName}    ${destdevice}
${udid}    30bcd142abf27b7812f260415117a4e50ee8a9de
${platformName}    iOS
${name}     My First Mobile Test
${automationName}    XCUITest
${xcodeOrgId}    269J2W3P7L
${xcodeSigningId}    iPhone
${usePrebuiltWDA}    True

*** Keywords ***
    setup and open ios app
        ${iosdriver}=    Open Application    ${APPIUM_SERVER2}    app=${app}    version=${version}    platform=${platform}    deviceName=${deviceName}    udid=${udid}    platformName=${platformName}    newCommandTimeout=2500
        ...    name=${name}    automationName=${automationName}    xcodeOrgId=${xcodeOrgId}    xcodeSigningId=${xcodeSigningId}    usePrebuiltWDA=${usePrebuiltWDA}
        Set Suite Variable    ${iosdriver}
*** Test Cases ***


*** Keywords ***