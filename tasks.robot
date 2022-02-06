*** Settings ***
Documentation     Get holdings from kite
# Resource        zerodha_resources.robot
Resource          hdfc_resources.robot
Library           DateTime
Library           Dialogs
Library           OperatingSystem
Library           RPA.Browser.Selenium    auto_close=${True}
Library           RPA.Desktop
Library           RPA.Robocorp.Vault

*** Tasks ***
Empty the download Directory
    Run Keyword And Ignore Error
    ...    Empty Directory    ${DOWNLOAD_DIR}
# Download reports from Zerodha
#    Log in to Kite website
#    download holdings
#    download taxpnl report
#    logout

Download PPF report
    Log in to HDFC website
    Go to bank statement page
    Logout from hdfc

*** Keywords ***
get date range
    ${cur_date} =    Get Current Date    result_format=datetime
    ${first day} =    set variable    01/${cur_date.month}/${cur_date.year}
    ${last day} =    set variable    ${cur_date.day}/${cur_date.month}/${cur_date.year}
    ${last day} =    Convert Date    ${last day}    date_format=%d/%m/%Y    result_format=%d/%m/%Y
    ${first day} =    Convert Date    ${first day}    date_format=%d/%m/%Y    result_format=%d/%m/%Y
    [Return]    ${first day}    ${last day}

Fill in data
    Wait Until Keyword Succeeds    ${timeout}    1 sec
    ...    select frame    ${p2_frame}
    select from list by value    name:selAccttype    SCA
    Sleep    1
    Select From List By Index    name:selAcct    1
    click element    xpath://*[@id="hideradio"]/span
    ${first day}    ${last day} =    get date range
    Input text    frmDatePicker    ${first day}
    Input text    toDatePicker    ${last day}
    select from list by value    name:cmbNbrStmt    10
    click element    xpath:/html/body/form/table[1]/tbody/tr[7]/td/a
    unselect frame

Go to bank statement page
    Wait Until Keyword Succeeds    ${timeout}    1 sec
    ...    Select Frame    ${sidepane_frame}
    current frame should contain    ${p1_enquiry_text}
    click element    ${p1_enquiry_xpath}
    click element    ${p1_acntStatmnt_xpath}
    unselect frame
    Fill in data

Log in to HDFC website
    Set Download Directory    ${DOWNLOAD_DIR}
    Open Available Browser    ${LOGIN URL}
    ${secret}=    Get Secret    hdfc
    Select Frame    ${p1_frame}
    Input Text When Element Is Visible    ${selector_user}    ${secret}[customerId]
    Click Element    ${selector_continue}
    Input Text When Element Is Visible    ${selector_pwd}    ${secret}[password]
    Click Element    ${selector_secure_img}
    Click Element    ${selector_submit}
    Unselect Frame

Logout from hdfc
    # Be very careful with frame! Anything inside frame can be selected only after selecting the frame
    Select Frame    common_menu1
    Click Element    xpath://img[@alt="Log Out"]
