*** Settings ***
Library           String
Library           Process
Library           AppiumLibrary
Library           pabot.PabotLib
Library           Util
Variables         ../variables/variable_${LANG}.py
Variables         ../variables/variable_additional_${LANG}.py
Variables         ../variables/server.py

*** Variables ***
${path_json}      ${EXECDIR}/
${nbr_in_strip}    0
${index_in_strip}    0

*** Keywords ***
Open Application TVaaS
    [Documentation]    Open Application TVaaS
    Encoding Convert To UTF8 All Variables
    ## For pabot, get variable
    Log    ${udid}    # udid of device
    Log    ${type}    # type of device: phone or tablet
    Log    ${name}    # name of device
    Log    ${appium}    # appium server port
    Set Global Variable    ${device_type}    ${type}
    ##
    ##
    ## Open Application
    Open Application    http://127.0.0.1:${appium}/wd/hub    platformName=Android    deviceName='${name}'    app=${app}    udid=${udid}
    ##
    ##
    I am on default page

Start Local Wiremock
    [Documentation]    Start wiremock app on the android
    Log    ${EXECDIR}
    ## Install wiremock apk
    Run Process    adb    -s    ${udid}    install    ${app_wiremock}
    ## Start wiremock app
    Run Process    adb    -s    ${udid}    shell    am    start
    ...    -n    com.handstandsam.wiremock.android.debug/com.handstandsam.wiremock.android.MainActivity
    ## And go back to home screen wiremock
    Run Process    adb    -s    ${udid}    shell    input    keyevent
    ...    3
    Sleep    1s
    #forward android local to computer localhost
    Run Process    adb    -s    ${udid}    forward    tcp:${wiremock}    tcp:8000

Delete to Wiremock
    [Documentation]    Delete ALL Json files on Wiremock server
    Run Process    push_wiremock    127.0.0.1:${wiremock}    SUP

Send to Wiremock
    [Arguments]    ${json_file}
    [Documentation]    Send to Wiremock server the Json file in argument
    Run Process    push_wiremock    127.0.0.1:${wiremock}    ADD    ${path_json}${json_file}

Send dir to Wiremock
    [Arguments]    ${directory}
    [Documentation]    Send to Wiremock server the all json's file from a directory
    Run Process    push_wiremock    127.0.0.1:${wiremock}    ADD    ${directory}    ALLFILES    stdout=/dev/null
    #
    #
    #Permission phone popup
    #    [Documentation]    Validate permission popup if exists
    #    Sleep    1s
    #    ${status}    ${ButtonVisible}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    //*[@resource-id="${appPackage}:id/md_buttonDefaultPositive"]    3s
    #    Log    ${status}
    #    Run Keyword If    '${status}' == 'PASS'    Click Element    //android.widget.TextView[@resource-id="${appPackage}:id/md_buttonDefaultPositive"]
    #    Comment    Run Keyword If    '${status}' == 'PASS'    Close allow phone popup
    Comment    Run Keyword If    '${status}' == 'PASS'    Close allow phone popup
    ...    ELSE    log    >> No permission phone popup
    #
    #Close allow phone popup
    #    [Documentation]    Close allow phone popup if exits
    #    Sleep    0.5s
    #    ${status}    ${ButtonVisible}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    //*[@resource-id="com.android.packageinstaller:id/permission_allow_button"]    3s
    #    Log    ${status}
    #    Run Keyword If    '${status}' == 'PASS'    Click Element    //*[@resource-id="com.android.packageinstaller:id/permission_allow_button"]
    #    #${status2}    ${ButtonVisible2}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    //*[@resource-id="com.android.packageinstaller:id/permission_allow_button"]    2s
    #    #Log    ${status2}
    #    #Run Keyword If    '${status2}' == 'PASS'    Click Element    //*[@resource-id="com.android.packageinstaller:id/permission_allow_button"]
    #
    #Close server error popup
    #    [Documentation]    Close server error popup - Not use it
    #    #Click Element    //android.widget.TextView[@resource-id="com.orange.tvaas.calabash:id/md_buttonDefaultPositive"]
    #    ${status}    ${ButtonVisible}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    //*[@resource-id="${appPackage}:id/md_buttonDefaultPositive"]    3s
    Comment    Run Keyword If    '${status}' == 'PASS'    Click Element    //android.widget.TextView[@resource-id="${appPackage}:id/md_buttonDefaultPositive"]
    ...    ELSE    log    >> No Error popup

I am authenticated
    [Documentation]    I authenticate if I am not authenticate
    Go to Orange & me page
    I am on Orange & me page
    ${statusAuth}    ${authent}=    Run Keyword And Ignore Error    Page Should Not Contain Text    ${right_user}
    Log    ${statusAuth}
    Run Keyword If    '${statusAuth}' == 'PASS'    Click authent button and authenticate
    ...    ELSE    log    >> I am already authenticated

I am not authenticated
    [Documentation]    I disconnect if I am already authenticated
    Sleep    1s
    Go to Orange & me page
    I am on Orange & me page
    ${Btn_disconnect}    ${values}=    Run Keyword And Ignore Error    Page Should Contain Element    //android.widget.Button[@resource-id="${appPackage}:id/IV_DISCONNECT"]
    # I disconnect if authenticated
    Run Keyword If    '${Btn_disconnect}' == 'PASS'    Click Element    //android.widget.Button[@resource-id="${appPackage}:id/IV_DISCONNECT"]
    Sleep    1s
    # popup confirm yes
    Run Keyword If    '${Btn_disconnect}' == 'PASS'    Click Element    //android.widget.TextView[@resource-id="${appPackage}:id/md_buttonDefaultPositive"]
    Sleep    2s
    Wait Until Page Contains Element    //android.widget.Button[@resource-id="${appPackage}:id/IV_AUTHENTICATE"]    5s
    Page Should Not Contain Element    //android.widget.Button[@resource-id="${appPackage}:id/IV_DISCONNECT"]

Click authent button and authenticate
    [Documentation]    Click on authent button On authent page
    Click Element    //android.widget.Button[@resource-id="${appPackage}:id/IV_AUTHENTICATE"]
    Identification

Identification
    [Documentation]    fill the identification page with Login and Password
    # check identification text
    Wait Until Page Contains    ${auth_identifier}    5
    Wait Until Page Contains    ${auth_password}    5
    #${upper_auth_btn_connect}=    Convert To Uppercase    ${auth_btn_connect}
    #Wait Until Page Contains    ${upper_auth_btn_connect}    5
    #Wait Until Page Contains    ${auth_btn_connect}    5
    Log    identification
    # enter login
    Input Text    //android.widget.EditText[@resource-id="${appPackage}:id/ET_EMAIL"]    ${right_user}
    # see password
    Click Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/text_input_password_toggle"]
    # enter password
    Input Text    //android.widget.EditText[@resource-id="${appPackage}:id/ET_PASSWORD"]    ${right_pass}
    # I click on login button
    Click Element    //android.widget.Button[@resource-id="${appPackage}:id/BTN_LOGIN"]

BadIdentification
    [Documentation]    fill the identification page with Login and Password
    # check identification text
    Wait Until Page Contains    ${auth_identifier}    5
    Wait Until Page Contains    ${auth_password}    5
    #${upper_auth_btn_connect}=    Convert To Uppercase    ${auth_btn_connect}
    #Wait Until Page Contains    ${upper_auth_btn_connect}    5
    #Wait Until Page Contains    ${auth_btn_connect}    5
    # enter login
    Input Text    //android.widget.EditText[@resource-id="${appPackage}:id/ET_EMAIL"]    ${right_user}
    # see password
    Click Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/text_input_password_toggle"]
    # enter password
    Input Text    //android.widget.EditText[@resource-id="${appPackage}:id/ET_PASSWORD"]    ${bad_pass}
    # I click on login button
    Click Element    //android.widget.Button[@resource-id="${appPackage}:id/BTN_LOGIN"]

Go to default page
    [Documentation]    In TabBar I click on default page = TV icon
    # In TabBar I click on default page = TV
    Wait Until Page Contains Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_live"]
    Click Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_live"]

I am on default page
    [Documentation]    I am on default page
    I am on TV page

Go to TV page
    [Documentation]    In TabBar I click on TV icon, I access to TV page
    # In TabBar I click on TV
    Wait Until Page Contains Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_live"]
    Click Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_live"]

I am on TV page
    [Documentation]    I am on TV page
    Wait Until Page Contains    ${TV}    10
    # kind of first channel exist
    Wait Until Page Contains Element    //android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_SUBTITLE"]    10s

Go to Replay page
    [Documentation]    In TabBar I click on Replay icon, I access to Replay page
    # In TabBar I click on Replay
    Wait Until Page Contains Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_replay"]
    Click Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_replay"]
    Sleep    1s

I am on Replay homepage
    [Documentation]    I am on Replay home page
    Wait Until Page Contains    ${replay}    10

I click on first program Now
    [Documentation]    I click on first program Now in first strip
    Log    I click on first program Now in first strip
    Wait Until Page Contains Element    //android.widget.FrameLayout[@content-desc="192"][1]
    Click Element    //android.widget.FrameLayout[@content-desc="192"][1]

I click on second program Now
    [Documentation]    I click on second program Now in first strip
    Log    I click on second program Now in first strip
    Wait Until Page Contains Element    //android.widget.FrameLayout[@content-desc="4"])[1]
    Click Element    //android.widget.FrameLayout[@content-desc="4"])[1]

I see the Program Details Page
    [Documentation]    I see the Program Details Page
    Log    I see the Program Details Page
    #progress bar
    Wait Until Page Contains Element    //android.widget.ProgressBar[@resource-id="${appPackage}:id/INFOSHEET_PROGRESS_BAR"]    10s
    #hours
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/INFOSHEET_HOURS"]    10s

I open live in full screen from detail page
    [Documentation]    I click Play on details page and Live stream is displayed in full screen
    I click Play on details page
    I see Live stream in full screen

I click Play on details page
    [Documentation]    I click Play on details page
    Log    I click Play on details page
    Wait Until Page Contains Element    //android.widget.ImageView[@resource-id="${appPackage}:id/INFOSHEET_PLAY_BUTTON"]    20s
    Click Element    //android.widget.ImageView[@resource-id="${appPackage}:id/INFOSHEET_PLAY_BUTTON"]
    #
    #I see Live stream in full screen first time
    #    Log    Permission phone popup
    #    Close allow phone popup
    #    Sleep    1s
    #    #Tap    //android.widget.LinearLayout[1]    130    300
    #    Go Back    # info page
    #    Sleep    1s
    #    Go Back    # Home TV
    #    Sleep    2s
    #    I click on first program Now
    #    I click Play on details page
    #    I see Live stream in full screen
    #

I see Live stream in full screen
    Log    I see Live stream in full screen
    #Log    play pause button
    Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_PLAY_PAUSE_BUTTON"]    40s
    #Log    start over button
    Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_STARTOVER_BUTTON"]    5s
    #Log    see player video in full screen
    Live player video running

Click play pause button
    # click play pause
    Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_PLAY_PAUSE_BUTTON"]    40s
    Click Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_PLAY_PAUSE_BUTTON"]

Click start over button
    Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_STARTOVER_BUTTON"]    40s
    Click Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_STARTOVER_BUTTON"]

Live player video running
    Wait Until Page Contains Element    //android.widget.RelativeLayout[@resource-id="${appPackage}:id/LIVE_PLAYER_VIDEO"]    40s
    Wait Until Page Contains Element    //android.widget.RelativeLayout[@resource-id="${appPackage}:id/LIVE_PLAYER_PROGRESS_BAR"]    10s

Go to Video home page
    [Documentation]    By TabBar icon, I access to VIDEO home page
    Sleep    0.5s
    Wait Until Page Contains Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_vod"]    10s
    Click Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_vod"]
    Sleep    1s

I am on Video home page
    [Documentation]    I am on VIDEO home page
    Sleep    0.5s
    Wait Until Page Contains    ${video}    10s

I see player Video
    [Documentation]    I see player VOD
    Log    I see Player VOD
    Wait Until Page Contains Element    xpath=//android.widget.LinearLayout[@resource-id="${appPackage}:id/action_bar_root"]    20s
    Wait Until Page Contains Element    xpath=//android.widget.RelativeLayout[@resource-id="${appPackage}:id/LIVE_PLAYER_VIDEO"]    40s
    Log    I see PLAY_PAUSE_BUTTON
    #Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${appPackage}:id/LIVE_PLAYER_PLAY_PAUSE_BUTTON"]    40s
    Wait Until Page Contains Element    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.ImageButton    40s

Go to Orange & me page
    [Documentation]    By TabBar icon, I access to Orange & moi page
    Sleep    0.5s
    Wait Until Page Contains Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_account"]    #//android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_account"]
    Click Element    //android.widget.LinearLayout[@resource-id="${appPackage}:id/tab_account"]
    Sleep    1s

I am on Orange & me page
    [Documentation]    I am on Orange & me page
    Wait Until Page Contains    ${oem_my_account}    10    # orange_moi

Click back button
    Wait Until Page Contains Element    //*[@resource-id="${appPackage}:id/TOOLBAR"]/android.widget.ImageButton
    Click Element    //*[@resource-id="${appPackage}:id/TOOLBAR"]/android.widget.ImageButton

Open live info banner
    [Documentation]    Display live info banner in full screen, if not displayed
    ${status}    ${BannerVisible}=    Run Keyword And Ignore Error    Count elements egal number    //android.widget.TextView[@resource-id="${appPackage}:id/action_channels"]    1
    Log    ${status}
    Run Keyword If    '${status}' == 'FAIL'    Tap    //android.widget.LinearLayout[1]    130    300
    ...    ELSE    log    >> Live Info Banner is already open
    Log    end open info banner
    # Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/action_channels"]    3s

Count elements egal number
    [Arguments]    ${element}    ${nbr}
    [Documentation]    count element should be egal to number
    #Get Count    //android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]    8
    #${Count}=    Get matching xpath count    //android.support.v7.widget.RecyclerView/android.widget.LinearLayout
    ${Count}=    Get matching xpath count    ${element}
    #${count}=    Convert To Integer    ${count}
    #Log    ${Count}
    #Run Keyword If    ${Count} > 1    Log    ${Count}
    Should Be Equal    '${count}'    '${nbr}'

Swipe in first strip until end
    [Documentation]    Swipe in first strip Now until end - 3 for phone 8 for tablet
    ${nbr_in_strip} =    Set Variable If    "${device_type}" == "phone"    3    8
    Log    ${nbr_in_strip}
    : FOR    ${INDEX}    IN RANGE    0    ${nbr_in_strip}
    \    Log    ${INDEX}
    \    Swipe    700    650    200    600    500
    # Swipe    1300    1550    700    1500    500

Swipe in second strip until end
    [Documentation]    Swipe in first strip All programs until end - 3 for phone 8 for tablet
    ${nbr_in_strip} =    Set Variable If    "${device_type}" == "phone"    6    8
    Log    ${nbr_in_strip}
    Swipe    700    600    700    200    500    # swipe up
    : FOR    ${INDEX}    IN RANGE    0    ${nbr_in_strip}
    \    Log    ${INDEX}
    \    Swipe    700    650    200    600    500
    Swipe    700    200    700    600    500    # swipe down

Access to now EPG
    [Documentation]    access and display now EPG
    ${uppercase_more} =    Convert To Uppercase    ${more}
    Click Element    //android.widget.LinearLayout[1]/android.widget.LinearLayout/android.widget.Button[@text="${uppercase_more}"]
    # programs title
    Wait Until Page Contains Element    //android.widget.TextView[@text="${epg_mosaic_toolbar_title}"]    10s    #Programmes
    # now title
    #Wait Until Page Contains Element    //android.widget.TextView[@text="${epg_mosaic_now_tab}"]    5s    # now
    ${GET_epg_mosaic_now_tab}=    Get Text    //android.support.v7.app.ActionBar.Tab[1]/android.widget.TextView
    ${GET_epg_mosaic_now_tab} =    Convert To Uppercase    ${GET_epg_mosaic_now_tab}
    ${epg_mosaic_now_tab} =    Convert To Uppercase    ${epg_mosaic_now_tab}
    #Log    ${GET_epg_mosaic_now_tab}
    #Log    ${epg_mosaic_now_tab}
    Should Be Equal    ${GET_epg_mosaic_now_tab}    ${epg_mosaic_now_tab}
    # to night title
    #Wait Until Page Contains Element    //android.widget.TextView[@text="${epg_mosaic_tonight_tab}"]    5s    # to night
    ${GET_epg_mosaic_tonight_tab}=    Get Text    //android.support.v7.app.ActionBar.Tab[2]/android.widget.TextView
    ${GET_epg_mosaic_tonight_tab} =    Convert To Uppercase    ${GET_epg_mosaic_tonight_tab}
    ${epg_mosaic_tonight_tab} =    Convert To Uppercase    ${epg_mosaic_tonight_tab}
    #Log    ${GET_epg_mosaic_tonight_tab}
    #Log    ${epg_mosaic_tonight_tab}
    Should Be Equal    ${GET_epg_mosaic_tonight_tab}    ${epg_mosaic_tonight_tab}
    # Now is selected
    #Element Attribute Should Match    //android.support.v7.app.ActionBar.Tab[1]/android.widget.TextView[@text="${epg_mosaic_now_tab}"]    selected    true
    Element Attribute Should Match    //android.support.v7.app.ActionBar.Tab[1]/android.widget.TextView    selected    true

Access to all programs EPG
    [Documentation]    access and display all programs EPG
    # swipe up
    # Swipe    600    600    600    200    500
    ${uppercase_more} =    Convert To Uppercase    ${more}
    Sleep    2s
    Click Element    android=UiSelector().text("${uppercase_more}").instance(1)
    # aujourd'hui title
    Wait Until Page Contains Element    //android.widget.TextView[@text="${day_today}"]    10s    # aujourd'hui

Info details page program
    # title
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/INFOSHEET_TITLE"]
    Wait Until Page Contains    ${title_program_detail}    5    # Nos chers voisins
    # logo image
    Wait Until Page Contains Element    //android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.LinearLayout[1]/android.widget.ImageView
    # start /end time
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/INFOSHEET_HOURS"]
    Wait Until Page Contains Element    //android.widget.TextView[@text="${hours_program_detail}"]    5s    # 00:01 - 23:12
    # program image
    # record button
    Wait Until Page Contains Element    //android.widget.Button[@text="${recordButton_program_detail}"]    5s    #ENREGISTRER button
    # program kind
    Wait Until Page Contains Element    //android.widget.TextView[@text="${kind_program_detail}"]    5s    #    Serie rires | FRA | 2017 | 1919 h 11
    # languageVersion VF
    Wait Until Page Contains Element    //android.widget.TextView[@text="VF"]    5s    # VF
    # director
    Wait Until Page Contains Element    //android.widget.TextView[@text="${titleDirector_program_detail}"]    5s    # Réalisé par :
    Wait Until Page Contains Element    //android.widget.TextView[@text="${nameDirector_program_detail}"]    5s    # Stephan Kopecky
    # avec actors
    Wait Until Page Contains Element    //android.widget.TextView[@text="${titleActors_program_detail}"]    5s    # Avec :
    Wait Until Page Contains Element    //android.widget.TextView[@text="${name1Actor_program_detail}"]    5s    # actor 1
    Wait Until Page Contains Element    //android.widget.TextView[@text="${name2Actor_program_detail}"]    5s    # actor 2
    Wait Until Page Contains Element    //android.widget.TextView[@text="${name3Actor_program_detail}"]    5s    # actor 3
    # longSummary
    Wait Until Page Contains Element    //android.widget.TextView[@text="${longSummary_program_detail}"]    5s    # summary
    # csa
    # share button
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="com.orange.tvaas.wiremock:id/action_share"]    5s    # share button

Get title kind first program Now
    Log    get program title kind TF1 in Now
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]    #//android.widget.LinearLayout[1]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[1]
    ${programTitleTF1}=    Get Text    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]    #//android.widget.LinearLayout[1]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[1]
    ${programKindTF1}=    Get Text    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_SUBTITLE"]    #//android.widget.LinearLayout[1]/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[2]
    Log    ${programTitleTF1}
    Log    ${programKindTF1}

Get title kind first program All
    Log    get program title kind TF1 in All progr
    Wait Until Page Contains Element    xpath=(//android.widget.FrameLayout[@content-desc="192"])[2]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[1]
    ${programTitleTF1}=    Get Text    xpath=(//android.widget.FrameLayout[@content-desc="192"])[2]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[1]
    ${programKindTF1}=    Get Text    xpath=(//android.widget.FrameLayout[@content-desc="192"])[2]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[2]
    Log    ${programTitleTF1}
    Log    ${programKindTF1}

Get title kind first program mosaic
    Log    get program title kind TF1 in mosaic
    Wait Until Page Contains Element    //*[@content-desc="192"]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]
    ${programTitleTF1}=    Get Text    //*[@content-desc="192"]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]
    ${programTitleTF1}=    Get Text    //*[@content-desc="192"]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_SUBTITLE"]
    Log    ${programTitleTF1}
    Log    ${programKindTF1}

Get title kind first program magazine
    Log    get program title kind TF1 in magzine
    #Wait Until Page Contains Element    //android.widget.LinearLayout[1]/android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]
    #${programTitleTF1}=    Get Text    //android.widget.LinearLayout[1]/android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.TextView[2]
    #${programKindTF1}=    Get Text    //android.widget.LinearLayout[1]/android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.TextView[3]
    Wait Until Page Contains Element    //android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.TextView[2]
    ${programTitleTF1}=    Get Text    //android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.TextView[2]
    ${programTitleTF1}=    Get Text    //android.widget.LinearLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.TextView[3]
    Log    ${programTitleTF1}
    Log    ${programKindTF1}

Get title kind first strip Video
    Log    Get first title & kind in first strip Video OCS Go
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]
    ${OCS_First_Video_Title}=    Get Text    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]
    ${OCS_First_Video_Kind}=    Get Text    //android.widget.TextView[@resource-id="${appPackage}:id/ITEM_SUBTITLE"]
    Log    ${OCS_First_Video_Title}
    Log    ${OCS_First_Video_Kind}
    Set Global Variable    ${OCS_First_Video_Title}    ${OCS_First_Video_Title}
    Set Global Variable    ${OCS_First_Video_Kind}    ${OCS_First_Video_Kind}

Get title kind second strip Video
    Log    Get first title & kind in second strip Video Afostream
    Swipe up
    Wait Until Page Contains Element    //android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]    5s
    ${AFRO_First_Video_Title}=    Get Text    //android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_TITLE"]
    ${AFRO_First_Video_Kind}=    Get Text    //android.widget.LinearLayout[2]/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[1]/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.TextView[@resource-id="${appPackage}:id/ITEM_SUBTITLE"]
    Log    ${AFRO_First_Video_Title}
    Log    ${AFRO_First_Video_Kind}
    Set Global Variable    ${AFRO_First_Video_Title}    ${AFRO_First_Video_Title}
    Set Global Variable    ${AFRO_First_Video_Kind}    ${AFRO_First_Video_Kind}

Click on Plus Afrostream strip
    Swipe up
    Swipe up
    # Afrostream strip More button exist
    ${uppercase_more} =    Convert To Uppercase    ${more}
    Wait Until Page Contains Element    //android.widget.LinearLayout[2]/android.widget.LinearLayout/android.widget.Button[@text="${uppercase_more}"]    5
    Click Element    //android.widget.LinearLayout[2]/android.widget.LinearLayout/android.widget.Button[@text="${uppercase_more}"]
    Sleep    1s
    Log    Check title Afrostream on mosaic
    #Wait Until Page Contains    ${title_Afrostream}    10
    Wait Until Page Contains Element    //android.widget.RelativeLayout/android.view.ViewGroup/android.widget.TextView    10s
    ${AFRO_Title}=    Get Text    //android.widget.RelativeLayout/android.view.ViewGroup/android.widget.TextView
    Log    ${AFRO_Title}
    Should Be Equal    ${AFRO_Title}    ${title_Afrostream}

Swipe up
    [Documentation]    swipe (x;Y) to (x;y) speed ms
    Swipe    300    650    300    320    400

Swipe down
    [Documentation]    swipe (x;y) to (x;y) speed ms
    Swipe    300    400    300    650    400

#######################################################################
