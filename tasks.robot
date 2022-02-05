*** Settings ***
Documentation     Get holdings from kite
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.Robocorp.Vault
Library           RPA.Desktop

*** Tasks ***
Fetch report from Zerodha Kite
    Open the intranet website
    Log in
    Insert Pin
    Go to holdings
    logout

*** Keywords ***
Open the intranet website
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
    Take Screenshot    output/screenshot.png

logout
    Go To    https://kite.zerodha.com/logout
