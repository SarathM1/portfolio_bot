*** Settings ***
Documentation     Get holdings from kite
# Resource        zerodha_resources.robot
Resource          hdfc_resources.robot
Library           DateTime
Library           Dialogs
Library           OperatingSystem
Library           RPA.Browser.Selenium    auto_close=${False}
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

*** Keywords ***
get date range
    ${cur_date} =    Get Current Date    result_format=datetime
    ${first day} =    set variable    01/${cur_date.month}/${cur_date.year}
    ${last day} =    set variable    ${cur_date.day}/${cur_date.month}/${cur_date.year}
    ${last day} =    Convert Date    ${last day}    date_format=%d/%m/%Y    result_format=%d/%m/%Y
    ${first day} =    Convert Date    ${first day}    date_format=%d/%m/%Y    result_format=%d/%m/%Y
    [Return]    ${first day}    ${last day}

Fill in data
    select frame    ${p2_frame_xpath}
    select from list by value    name:selAccttype    SCA
    Execute Manual Step    Please select the account
    click element    xpath://*[@id="hideradio"]/span
    ${first day}    ${last day} =    get date range
    Input text    frmDatePicker    ${first day}
    Input text    toDatePicker    ${last day}
    select from list by value    name:cmbNbrStmt    10
    click element    xpath:/html/body/form/table[1]/tbody/tr[7]/td/a
    unselect frame

Go to bank statement page
    sleep    ${timeout}
    select frame    ${p1_frame_xpath}
    current frame should contain    ${p1_enquiry_text}
    click element    ${p1_enquiry_xpath}
    click element    ${p1_acntStatmnt_xpath}
    unselect frame
    sleep    ${timeout}
    Fill in data

Log in to HDFC website
    Set Download Directory    ${DOWNLOAD_DIR}
    Open Available Browser    ${LOGIN URL}
    ${secret}=    Get Secret    hdfc
    Type Text    ${secret}[customerId]
    RPA.Desktop.Press Keys    enter
    Sleep    1
    Type Text    ${secret}[password]
    Sleep    1
    Execute Manual Step    Please click on the checkbox and click LOGIN
