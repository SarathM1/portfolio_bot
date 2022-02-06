*** Settings ***
Library           DateTime
Library           Dialogs
Library           html_tables.py
Library           OperatingSystem
Library           RPA.Browser.Selenium    auto_close=${True}
Library           RPA.Desktop
Library           RPA.Robocorp.Vault
Library           RPA.Tables

*** Variables ***
${LOGIN URL}      https://netbanking.hdfcbank.com/netbanking/
# Login page
${selector_user}    css:input[name="fldLoginUserId"]
${selector_continue}    xpath://*[@id="pageBody"]/div[1]/form/div[3]/div/div/div[2]/div[2]/div[2]/div[2]/a
${selector_pwd}    css:input[name="fldPassword"]
${selector_secure_img}    css:input[name="chkrsastu"]
${selector_submit}    xpath:/html/body/form/div/div[3]/div/div[1]/div[2]/div[1]/div[4]/div[2]/a
# landing page
${p1_frame}       login_page
${p1_enquiry_xpath}    xpath://*[@id="enquirytab"]
${p1_enquiry_text}    Enquire
${p1_acntStatmnt_xpath}    xpath://*[@id="SIN_nohref"]/a/span
#Summary Page
${sidepane_frame}    left_menu
# Download report page
${p2_frame}       main_part
${timeout}        3s
${selector_topBar}    common_menu1
${selector_logout}    xpath://img[@alt="Log Out"]
${statement_table}    xpath://*[@id="1"]

*** Keywords ***
Read HTML table as Table
    [Arguments]    ${locator}    ${part}
    # ${html_table}=    Get Element Attribute    css:table    outerHTML
    ${html_table}=    Get Element Attribute    ${locator}    ${part}
    ${table}=    Read Table From Html    ${html_table}
    ${dimensions}=    Get Table Dimensions    ${table}
    ${first_row}=    Get Table Row    ${table}    ${0}
    # Log To Console    ${first_row}
    # ${first_cell}=    RPA.Tables.Get Table Cell    ${table}    ${0}    ${0}
    # FOR    ${row}    IN    @{table}
    #    Log To Console    ${row}
    # END
    [Return]    ${table}

download monthly statement
    sleep    2
    Select Frame    ${p2_frame}
    ${table} =    hdfc_resources.Read HTML table as Table    locator=${statement_table}    part=outerHTML
    Create Directory    ${HDFC_DOWNLOAD_DIR}
    Write table to CSV    ${table}    ${HDFC_DOWNLOAD_DIR}/monthly_statement.csv
    Unselect Frame

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
    Wait Until Keyword Succeeds    ${timeout}    1 sec
    ...    Select From List By Index    name:selAcct    1
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
    Select Frame    ${selector_topBar}
    Click Element    ${selector_logout}
