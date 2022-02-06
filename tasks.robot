*** Settings ***
Documentation     Get holdings from kite
# Resource        zerodha_resources.robot
Library           RPA.Robocorp.Vault
Library           RPA.Desktop
Library           OperatingSystem
Library           RPA.Browser.Selenium    auto_close=${False}
Library           Dialogs

*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download/zerodha

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

*** Keywords ***
Log in to HDFC website
    Set Download Directory    ${DOWNLOAD_DIR}
    Open Available Browser    https://netbanking.hdfcbank.com/netbanking/
    ${secret}=    Get Secret    hdfc
    Type Text    ${secret}[customerId]
    RPA.Desktop.Press Keys    enter
    Sleep    1
    Type Text    ${secret}[password]
    Sleep    1
    Execute Manual Step    Please click on the checkbox and click LOGIN
