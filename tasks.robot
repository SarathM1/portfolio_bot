*** Settings ***
Documentation     Get holdings from kite
Library           RPA.Browser.Selenium    auto_close=${False}
Library           RPA.Robocorp.Vault
Library           RPA.Desktop
Library           html_tables.py
Library           RPA.Tables
Library           OperatingSystem

*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download

*** Tasks ***
Empty the download Directory
    Empty Directory    ${DOWNLOAD_DIR}

Fetch report from Zerodha Kite
    Open the intranet website
    Log in
    Insert Pin
    Go to holdings
    Read HTML table as Table

Fetch report from console
    Go to console download taxpnl report
    # logout

*** Keywords ***
Open the intranet website
    Set Download Directory    ${DOWNLOAD_DIR}
    Open Available Browser    https://kite.zerodha.com

Log in
    ${secret}=    Get Secret    zerodha
    Input Text    userid    ${secret}[username]
    Input Password    password    ${secret}[password]
    Submit Form

Insert Pin
    ${secret}=    Get Secret    zerodha
    Sleep    1
    Input Password    id:pin    ${secret}[pin]
    Submit Form

Go to holdings
    Sleep    1
    Go To    https://kite.zerodha.com/holdings
    Capture Page Screenshot    ${DOWNLOAD_DIR}/analytics.png

Wait for Download To Complete
    Wait Until Keyword Succeeds    10 sec    2 sec
    ...    File Should Exist
    ...    ${DOWNLOAD_DIR}/taxpnl-*

Go to console download taxpnl report
    Go To    https://console.zerodha.com/reports/taxpnl/eq
    Click Button When Visible    class:btn-blue
    Click Element When Visible    class:taxpnl-download
    Wait for Download To Complete

Read HTML table as Table
    ${html_table}=    Get HTML table
    ${table}=    Read Table From Html    ${html_table}
    ${dimensions}=    Get Table Dimensions    ${table}
    ${first_row}=    Get Table Row    ${table}    ${0}
    Log To Console    ${first_row}
    ${first_cell}=    RPA.Tables.Get Table Cell    ${table}    ${0}    ${0}
    FOR    ${row}    IN    @{table}
        Log To Console    ${row}
    END
    Write table to CSV    ${table}    ${DOWNLOAD_DIR}/equity_holdings.csv

Get HTML table
    ${html_table}=    Get Element Attribute    css:table    outerHTML
    [Return]    ${html_table}
    #app > div.container.wrapper > div.container-right > div > div > section > div > div > table

logout
    Go To    https://kite.zerodha.com/logout
