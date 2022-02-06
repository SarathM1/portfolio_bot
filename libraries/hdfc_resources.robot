*** Variables ***
${DOWNLOAD_DIR}    ${CURDIR}/output/download/zerodha
${LOGIN URL}      https://netbanking.hdfcbank.com/netbanking/
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
