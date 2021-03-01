### ùûüàâéèêëïîôœ
*** Settings ***
Suite Setup
Test Setup
Library           AppiumLibrary
Library           String
Library           OperatingSystem
Resource          Functions/Android/General.robot
Resource          Variables.robot
#Library           ./Util.py

*** Variables ***

*** Test Cases ***

Startup
    [Tags]    Android    NR
    Launch App

Allow Permissions
    [Tags]    Android
    # AllowPermissions
    Click_ALLOW_Allow
Click Start
    [Tags]    Android    NR
    ClickDJINGO
Click Login
    [Tags]    Android    NR
    Login
    Sleep    3s
    # AllowPermissions
    Click_ALLOW_Allow

Click Restart
    [Tags]    Android    NR
    Restart

H02 Select New Twnnant H02        
    [Tags]    Android    NR
    SelectNewTennant

H04 Scroll up history
    [Tags]    Android    NR
    ScrollUpHistory
       
Select text&voice input method
    [Tags]    Android    NR
    Click Menu icon
#    Click Parametres
    Click Settings
    Click Conversation
#    Click Mode de Saisie
    Click Select input method    
#    Click Entrée texte et audio
    Click Text & Audio input
    Return to menu

Populate history
     # FOR    ${i}    IN RANGE    0    50
         # Input text in history    ${i} Comment t'appelles-tu ?
         # ${i}    Set Variable    ${i}+1
     # END
    Input text in history    Comment ca va ?
    Sleep    20s
    Wait for reply
    Input text in history    Quelle est la température a Berlin ?
    Sleep    3s
    Wait for reply
    Input text in history    Quelle est la meteo ce soir a Paris ?
    Sleep    3s
    Wait for reply
    Input text in history    Quelle heure est-il dans Tolouse
    Sleep    3s
    Wait for reply

    Sleep    3s
    Input text in history    Quelle heure est-il dans Bucharest
    Sleep    3s
    Wait for reply
    Input text in history    Quelle est la meteo ce soir a Lyon ?
    Sleep    3s
    Wait for reply
    Sleep    1s
    Input text in history    Quelle heure est-il dans Bucharest
    Sleep    3s
    Wait for reply

Scroll to top   
    Scroll_to_top

Scroll to bottom
    Scroll_to_bottom

Erase History
    Erase history

Populate history and check feedback
    Input text in history    Quelle est la meteo ce soir a Paris ?
    Sleep    15s
    Long click conversation item


HD01 Long press on a conversation item + Delete button
    Long click conversation item
    Wait Until Page Contains Element    xpath=//android.widget.LinearLayout[@resource-id='${appPackage}:id/contextual_menu_delete']    30s
    Click Element    xpath=//android.widget.LinearLayout[@resource-id='${appPackage}:id/contextual_menu_delete']
    Wait Until Page Contains    This conversation item will be deleted.    5s
    Sleep    1s
    Wait Until Page Contains Element  id=${ConversationActivity}:id/tv_action_text    2s
    Click Element    id=${ConversationActivity}:id/tv_action_text
    Wait Until Page Contains Element  xpath=//android.widget.TextView[2][@resource-id='${ConversationActivity}:id/tv_action_text']    5s
    Click Element  xpath=//android.widget.TextView[2][@resource-id='${ConversationActivity}:id/tv_action_text']
    Sleep    2s
    Click Element    xpath=/history/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.TextView

HD02 ... Delete > No item
    Click 3 dots menu
 
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete']
    Sleep    2s
    Element Should Be Disabled       id=confirmation_buttons_group_positive
    Element Text Should Be    id=toolbar_title    0 selected elements
    Delete_menu_press_Cancel
    Sleep    2s

HD03 ... Delete > 1 item
    Click 3 dots menu
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete']
    Sleep    2s
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Sleep    1s
    Element Should Be Enabled    id=confirmation_buttons_group_positive
    Element Text Should Be    id=toolbar_title    1 selected element
    HW_BACK
    Sleep    2s

HD04 ... Delete > Select more elements
    Click 3 dots menu
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete']
    Sleep    2s
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Swipe Down    
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Element Should Be Enabled    id=confirmation_buttons_group_positive
    Element Text Should Be    id=toolbar_title    2 selected elements
    HW_BACK
    Sleep    2s

HD05 ... Delete > Select more items and delete
    Click 3 dots menu
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete']
    Sleep    2s
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Swipe Down    
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Element Should Be Enabled    id=confirmation_buttons_group_positive
    Element Text Should Be    id=toolbar_title    2 selected elements    
    Delete_menu_press_Delete
    HW_BACK
    Sleep    2s

HD06 ... Delete > Select more items and cancel
    Click 3 dots menu
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete']
    Sleep    2s
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Swipe Down    
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/conversation_entry_delete_cb_select_entry']
    Element Should Be Enabled    id=confirmation_buttons_group_positive
    Element Text Should Be    id=toolbar_title    2 selected elements    
    Sleep    5s
    Delete_menu_press_Cancel
    HW_BACK
    Sleep    2s
HD09 ... Delete > select a day    
    Wait Until Page Contains Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/select_day_header_cb_select']    30s
    Click Element    xpath=//android.widget.CheckBox[@resource-id='${appPackage}:id/select_day_header_cb_select']
Exit
    Close Application    
*** Keywords ***
