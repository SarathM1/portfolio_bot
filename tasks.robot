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
    select frame    css:html > frameset > frameset > frameset > frame:nth-child(1)
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
    Select Frame    login_page
    # <input type="text" class="form-control text-muted" style="width: 245px;height: 30px"
    # name="fldLoginUserId" maxlength="15" size="13" onkeypress="return fSubmit(event);"
    # value="" oncopy="return false" ondrag="return
    # false" ondrop="return false" onpaste="return false" onfocus="return false">
    Input Text When Element Is Visible    css:input[name="fldLoginUserId"]    ${secret}[customerId]
    Click Element    xpath://*[@id="pageBody"]/div[1]/form/div[3]/div/div/div[2]/div[2]/div[2]/div[2]/a
    Input Text When Element Is Visible    css:input[name="fldPassword"]    ${secret}[password]
    Click Element    css:input[name="chkrsastu"]
    Click Element    xpath:/html/body/form/div/div[3]/div/div[1]/div[2]/div[1]/div[4]/div[2]/a
    Unselect Frame

Logout from hdfc
    # Be very careful with frame! Anything inside frame can be selected only after selecting the frame
    Select Frame    common_menu1
    Click Element    xpath://img[@alt="Log Out"]
