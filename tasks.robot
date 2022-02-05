*** Settings ***
Documentation     Insert the sales data for the week and export it as a PDF.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.Robocorp.Vault

*** Tasks ***
Insert the sales data for the week and export it as a PDF
    Open the intranet website
    Log in
    Insert Pin

*** Keywords ***
Open the intranet website
    Open Available Browser    https://kite.zerodha.com

Log in
    ${secret}=    Get Secret    zerodha
    Log To Console    ${secret}
    Input Text    userid    ${secret}[username]
    Input Password    password    ${secret}[password]
    Submit Form

Insert Pin
    ${secret}=    Get Secret    zerodha
    Sleep    1
    Input Password    id:pin    ${secret}[pin]
    Submit Form

Go to holdings
    # <a href="/holdings" class=""><span class="icon icon-briefcase"></span></a>
