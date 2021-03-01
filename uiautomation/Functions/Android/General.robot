*** Settings ***
Library           AppiumLibrary
Library           String
Library           OperatingSystem
Resource          ../../Variables.robot
#Resource          Variables.robot
*** Keywords ***
# Launch App
    # Log   Start ${AppName}
    # Open Application    http://127.0.0.1:${appium}/wd/hub    platformName=Android    deviceName=${name}
    # ...     appPackage=${appPackage}  udid=${udid}  appActivity=${MainActivity}
    # Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='com.orange.labs.connectone:id/sign_in']    60s
    # Log   End of startup:${AppName}
Launch App
    Log   Start ${AppName}
    Open Application    http://127.0.0.1:${appium}/wd/hub    platformName=Android    deviceName=${name}
    ...     appPackage=${appPackage}  udid=${udid}  appActivity=${MainActivity}
#    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='com.orange.labs.connectone:id/sign_in']    60s
    Log   End of startup:${AppName}
    Sleep    5s
    Log   End of startup:${AppName}

Teardow
    Run Keyword If Test Failed    RestartApp
    Run Keyword If Test Passed    log    "Passed"

RestartApp
    Close Application
#    sleep    5s
    Launch App
    
AllowPermissions
    # Click Element    xpath=//android.widget.Button[@resource-id='com.android.packageinstaller:id/permission_allow_button']
    Sleep     3s
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//android.widget.TextView[@text='Allow SmartVoiceKit Demo App to access photos, media, and files on your device?']
    Run Keyword If    ${present}    Click_ALLOW_Allow
Click_ALLOW_Allow
    ${ALLOW}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//android.widget.Button[@text='ALLOW']
    Run Keyword If    ${ALLOW}    Click Element    xpath=//android.widget.Button[@text='ALLOW']
    ${Allow}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//android.widget.Button[@text='Allow']
    Run Keyword If    ${Allow}    Click Element    xpath=//android.widget.Button[@text='Allow']

ClickDjingo
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButtonOrange']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButtonOrange']
Login
    # Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButton']    30s
    # Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButton']

    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']    30s
    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']
    Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']    ${username}
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_login_button_resume']

# # New login step added by login API #  USED ONLY FOR #### USERS  
    # Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_mc_button_classic']    30s
    # Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_mc_button_classic']
# #
    Wait Until Page Contains Element  xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']    30s
    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']    
    Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']   ${passwd}
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_button_confirm']
  
Restart
# Djingo is not your default assistant,  
    Wait Until Page Contains Element  xpath=//android.widget.Button[@resource-id='android:id/button2']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='android:id/button2']
# The app will be restarted, click CONFIRM
    # Wait Until Page Contains Element  xpath=//android.widget.Button[@resource-id='android:id/button3']    30s
    # Click Element    xpath=//android.widget.Button[@resource-id='android:id/button3']



   
#H01
SelectNewTennant
    #Click menu 
    # Wait Until Page Contains Element  xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_drawer']    30s
    # Click Element    xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_drawer']
    # #Click Parametres
    Click Menu icon
    
    # Wait Until Page Contains Element  xpath=//android.widget.CheckedTextView[@text='Paramètres']    30s
    # Click Element  xpath=//android.widget.CheckedTextView[@text='Paramètres']
    Wait Until Page Contains Element  xpath=//android.widget.CheckedTextView[@text='Settings']    30s
    Click Element  xpath=//android.widget.CheckedTextView[@text='Settings']



    #Click Tennant 
    Wait Until Page Contains Element     xpath=//android.widget.TextView[@text='Server / Tenant']    30s
    Click Element    xpath=//android.widget.TextView[@text='Server / Tenant']
    
    
    
    
    # Wait Until Page Contains Element     xpath=//android.widget.TextView[@text='MVP Staging 002']    30s
    Wait Until Page Contains    MVP Staging 002    30s
    Click Element    xpath=//android.view.ViewGroup[3]/android.widget.RadioButton


    
    
    #Click Confirm
    Wait Until Page Contains Element  xpath=//android.widget.Button[@resource-id='android:id/button3']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='android:id/button3']
    #Click Djingo
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButtonOrange']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/activityAuthentication_loginButtonOrange']
    
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']    30s
    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']
        
    Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_login_editext']    ${username}
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_login_button_resume']
# # New login step added by login API #    Userd only for login ###
    # Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_mc_button_classic']    30s
    # Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_mc_button_classic']    
# #
    Wait Until Page Contains Element  xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']    30s
    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']    
    Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/was_sdk_smartauthent_explicit_id_password']   ${passwd}
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/was_sdk_button_confirm']








    
Fill_history
    Input text in history    Comment t'appel tu ?
    Sleep    3
Click Menu icon
    #Click menu 
    Wait Until Page Contains Element  xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_drawer']    30s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_drawer']
Click Home icon
    #Click menu 
    Wait Until Page Contains Element  xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_conversation']    30s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id='${appPackage}:id/bottom_nav_conversation']
    
    
# Click Parametres
    # Wait Until Page Contains Element  xpath=//android.widget.CheckedTextView[@text='Paramètres']    30s
    # Click Element  xpath=//android.widget.CheckedTextView[@text='Paramètres']
Click Settings
    Wait Until Page Contains Element  xpath=//android.widget.CheckedTextView[@text='Settings']    30s
    Click Element  xpath=//android.widget.CheckedTextView[@text='Settings']

Click Conversation
    #Click Tennant 
    Wait Until Page Contains Element     xpath=//android.widget.TextView[@text='Conversation']    30s
    Click Element    xpath=//android.widget.TextView[@text='Conversation']        

# Click Mode de Saisie
    # Wait Until Page Contains Element     xpath=//android.widget.TextView[@text='Mode de Saisie']    30s
    # Click Element    xpath=//android.widget.TextView[@text='Mode de Saisie']
Click Select input method
    Wait Until Page Contains Element     xpath=//android.widget.TextView[@text='Select input method']    30s
    Click Element    xpath=//android.widget.TextView[@text='Select input method']

# Click Entrée texte et audio
    # Wait Until Page Contains Element     xpath=//android.widget.CheckedTextView[@text='Entrée texte et audio']    30s
    # Click Element    xpath=//android.widget.CheckedTextView[@text='Entrée texte et audio']
Click Text & Audio input
    Wait Until Page Contains Element     xpath=//android.widget.CheckedTextView[@text='Text & Audio input']    30s
    Click Element    xpath=//android.widget.CheckedTextView[@text='Text & Audio input']



Return to menu
    [Documentation]    Hardware keys KeyCodes BACK = 4    MENU = 82    APP_SWITCH=187   (dec values)
    Press Keycode    4
    Sleep    0.5s 
    Press Keycode    4
    Sleep    0.5s
    Click Home icon
    Sleep    0.5s
Input text in history
    [Arguments]    ${charstr}
    # Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/conversation_fragment_input_edit_text']    30s
# #    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/conversation_fragment_input_edit_text']
    # Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/conversation_fragment_input_edit_text']    ${charstr}
    # Click Element    xpath=//android.widget.ImageButton[@resource-id='${appPackage}:id/conversation_fragment_send_button']
    
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/et_user_input']    30s
#    Click Element    xpath=//android.widget.EditText[@resource-id='${appPackage}:id/conversation_fragment_input_edit_text']
    Input Text   xpath=//android.widget.EditText[@resource-id='${appPackage}:id/et_user_input']    ${charstr}
    Wait Until Page Contains Element    xpath=//android.widget.ImageButton[@resource-id='${appPackage}:id/btn_send_text']    60s
    Click Element    xpath=//android.widget.ImageButton[@resource-id='${appPackage}:id/btn_send_text']
Wait for reply
    # Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_now_ui_message']    60s
    # Log    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_now_ui_message']
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_tv_message']    60s
    log    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_tv_message']


    
Swipe up
    [Documentation]    swipe (x;Y) to (x;y) speed ms
    Swipe    300    850    300    200    100

Swipe down
    [Documentation]    swipe (x;y) to (x;y) speed ms
    Swipe    300    400    300    1400    300

Erase history
    #Sleep    10s
    #Click Element    //android.view.ViewGroup[1][@resource-id='${appPackage}:id/activityHome_toolbar']
    #Click Element    //*[@type="android.widget.ImageView"]
    #Click Element    //android.view.ViewGroup[1]/android.view.ViewGroup[1]/android.widget.ImageView[0]
    #/android.widget.ImageView
    #Click Element    xpath=//android.view.ViewGroup[1][@resource-id='${appPackage}:id/activity_home_drawer_header']
    #xpath=//android.view.ViewGroup[3]/android.widget.RadioButton
    
    Click 3 dots menu    
    # Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Supprimer tout']    30s
    # Click Element    xpath=//android.widget.TextView[@text='Supprimer tout']
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Delete all']    30s
    Click Element    xpath=//android.widget.TextView[@text='Delete all']
        
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/btn_delete']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/btn_delete']

Click 3 dots menu
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/activityHome_toolbarTitle']    30s
    Long Press    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/activityHome_toolbarTitle']    1s
 
Long click conversation item
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_tv_message']    30s
    Long press    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/text_response_tv_message']    3s

Delete_menu_press_Delete
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/confirmation_buttons_group_positive']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/confirmation_buttons_group_positive']    
Delete_menu_press_Cancel
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/confirmation_buttons_group_negative']    30s
    Click Element    xpath=//android.widget.Button[@resource-id='${appPackage}:id/confirmation_buttons_group_negative']    

Scroll_to_top
        FOR    ${i}    IN RANGE    0    500
        Swipe down
#    \    ${el}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Vous avez atteint le début de votre historique de conversation avec l'assistant Djingo.']
        ${el}    Run Keyword And Return Status    Element SHould Be Visible    xpath=//android.widget.TextView[@resource-id='${appPackage}:id/tv_message']
    # \    log    ${el}
        Run Keyword If    ${el}     Exit For Loop
        ${i}    Set Variable    ${i}+1
         END    
Scroll_to_bottom
#    Wait Until Page Contains Element    xpath=//android.widget.ImageButton[@resource-id='${appPackage}:id/btn_go_to_bottom']    30
    Click Element    xpath=//android.widget.ImageButton[@resource-id='${appPackage}:id/btn_go_to_bottom']

HW_BACK
    [Documentation]    Hardware keys KeyCodes BACK = 4    MENU = 82    APP_SWITCH=187   (dec values)
    Sleep    10
    Press Keycode    4
    Sleep    0.5s 
HW_MENU
    [Documentation]    Hardware keys KeyCodes BACK = 4    MENU = 82    APP_SWITCH=187   (dec values)
    Press Keycode    4
    Sleep    0.5s 
HW_APP_SWITCH
    [Documentation]    Hardware keys KeyCodes BACK = 4    MENU = 82    APP_SWITCH=187   (dec values)
    Press Keycode    4
    Sleep    0.5s 








     # Click Element    xpath=//android.widget.RadioButton[@text='MVP Staging 002']

   ################################################################################  
   # To change the tenant the application will be restarted
   # id/button3 

   ################################################################################
    #Click Element     xpath=//android.widget.RadioButton[@text='MVP Staging 002']




    #Select new tennant
    
    #Click Element     xpath=//android.widget.TextView[@text='MVP Staging 002']
    # Wait Until Page Contains Element     xpath=//android.widget.ImageView[0]    30s
    
    # Click Element     xpath=//android.widget.ImageView[0]
    # Sleep    3s

    # Click Element    xpath=//android.widget.RadioButton[1]
    
    
    
    
    # Click Element    xpath=//android.widget.TextView[@text='MVP Staging 002']/preceding-sibling::android.widget.RadioButton


     # Input Text   xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/email']    ${username}
# ##     sleep    1s
     # Click Element    xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/password']     
     # Input Text   xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/password']  ${passwd}
# Swipe down 330
    # Swipe    300    650    300    320    400

# Sign_in

     # Click Element   xpath=//android.widget.Button[@resource-id='com.orange.labs.connectone:id/sign_in']
# #     sleep  10s
# #     Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/email']    30s
# #    Wait Until Page Contains Element     xpath=//android.widget.CheckBox[@resource-id='com.orange.labs.connectone:id/terms_checkbox']    30s
     # Click Element    xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/email']
     # Input Text   xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/email']    ${username}
# ##     sleep    1s
     # Click Element    xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/password']     
     # Input Text   xpath=//android.widget.EditText[@resource-id='com.orange.labs.connectone:id/password']  ${passwd}
# ##     sleep    1s
# #    driver.pressKeyCode(AndroidKeyCode.KEYCODE_NUMPAD_ENTER );
    # Wait Until Page Contains Element     xpath=//android.widget.CheckBox[@resource-id='com.orange.labs.connectone:id/gdpr_checkbox']    60s
     # Click Element    xpath=//android.widget.CheckBox[@resource-id='com.orange.labs.connectone:id/gdpr_checkbox']
# ##     sleep    1s
    # Wait Until Page Contains Element     xpath=//android.widget.CheckBox[@resource-id='com.orange.labs.connectone:id/terms_checkbox']    60s     
     # Click Element    xpath=//android.widget.CheckBox[@resource-id='com.orange.labs.connectone:id/terms_checkbox']
# ##     sleep    1s

    # Wait Until Page Contains Element     xpath=//android.widget.Button[@resource-id='com.orange.labs.connectone:id/sign_in']    60s
     # Click Element   xpath=//android.widget.Button[@resource-id='com.orange.labs.connectone:id/sign_in']
# #    Input Text   xpath=//input[@type='email']   ${username}
# #    Input Text   xpath=//input[@type='password']    ${passwd}
# #     sleep    5s

# Browse
    # Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_dashboard']    60s
    # Click Element   xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_dashboard']
# #    sleep    1s
    # Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_devices']    60s
    # Click Element   xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_devices']
# #    sleep    1s
    # Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_home']    60s    
    # Click Element   xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_home']
# #    sleep    1s
    # Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_home']    60s    
    # Click Element   xpath=//android.widget.FrameLayout[@resource-id='com.orange.labs.connectone:id/tab_home']
# #    sleep   1s
