*** Settings ***
Library           html_tables.py
Library           Reserved
Library           RPA.Browser.Selenium    auto_close=${True}
Library           RPA.Desktop
Library           RPA.Robocorp.Vault
Library           RPA.Tables

*** Keywords ***
Log in to Kite website
    Set Download Directory    ${DOWNLOAD_DIR}
    Open Available Browser    https://kite.zerodha.com
    Log in

Log in
    ${secret}=    Get Secret    zerodha
    Input Text    userid    ${secret}[username]
    Input Password    password    ${secret}[password]
    Submit Form
    Sleep    1
    Input Password    id:pin    ${secret}[pin]
    Submit Form

download holdings
    Sleep    1
    Go To    https://kite.zerodha.com/holdings
    Capture Page Screenshot    ${DOWNLOAD_DIR}/analytics.png
    ${table} =    Read HTML table as Table    locator=css:table    part=outerHTML
    Write table to CSV    ${table}    ${DOWNLOAD_DIR}/equity_holdings.csv

Wait for Download To Complete
    Wait Until Keyword Succeeds    10 sec    2 sec
    ...    File Should Exist
    ...    ${DOWNLOAD_DIR}/taxpnl-*

download taxpnl report
    Go To    https://console.zerodha.com/reports/taxpnl/eq
    Click Button When Visible    class:btn-blue
    Click Element When Visible    class:taxpnl-download
    Wait for Download To Complete

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

logout
    Go To    https://kite.zerodha.com/logout
