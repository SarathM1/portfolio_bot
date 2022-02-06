*** Settings ***
Documentation     Get holdings from kite
Resource          zerodha_resources.robot
Library           OperatingSystem

*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download

*** Tasks ***
Empty the download Directory
    Empty Directory    ${DOWNLOAD_DIR}

Download reports from Zerodha
    Go to Kite website
    Log in
    download holdings
    download taxpnl report
    logout
