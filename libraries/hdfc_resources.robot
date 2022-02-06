*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download/zerodha
${LOGIN URL}      https://netbanking.hdfcbank.com/netbanking/
${BROWSER}        firefox
${User Name}      SARATH M
# landing page
${p1_frame_xpath}    xpath:/html/frameset/frameset/frame
${p1_enquiry_xpath}    xpath://*[@id="enquirytab"]
${p1_enquiry_xpath}    xpath://*[@id="enquirytab"]
${p1_enquiry_text}    Enquire
${p1_acntStatmnt_xpath}    xpath://*[@id="SIN_nohref"]/a/span
# Download report page
${p2_frame_xpath}    xpath:/html/frameset/frameset/frameset/frame[1]
${p2_export_name}    fldFormatType
${p2_export_type}    C
${p2_submit_cssSelector}    css:.formtable > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(1) > a:nth-child(1) > img:nth-child(1)
${timeout}        3s
${page title}     Welcome to HDFC Bank NetBanking
