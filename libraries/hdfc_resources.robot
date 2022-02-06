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
