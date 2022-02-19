*** Settings ***
Documentation     Download data from multiple sites and create a report
Resource          zerodha_resources.robot
Resource          hdfc_resources.robot

*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download/zerodha
${HDFC_DOWNLOAD_DIR}    ${CURDIR}/output/download/hdfc

*** Tasks ***
Empty the download Directory
    Run Keyword And Ignore Error
    ...    Empty Directory    ${DOWNLOAD_DIR}
    Run Keyword And Ignore Error
    ...    Empty Directory    ${HDFC_DOWNLOAD_DIR}

Download reports from Zerodha
    Log in to Kite website
    download holdings
    download taxpnl report
    logout

Download monthly bank statement
    Log in to HDFC website
    Go to bank statement page
    download monthly statement
    Logout from hdfc
