*** Settings ***
Library  SeleniumLibrary
Library	Screenshot	
Test Setup    Open Browser    https://www.google.com/    chrome
Test Teardown    Close Browser

*** Variables ***
${BROWSER}   chrome
${SELSPEED}  0.4s
${FIRSTNAME}    Anna
${LASTNAME}    While
${USERNAME}     whilea----h@gmail.com
${PASSWORD}    6NydKnDJRVqC*cw
#Navigation catalogue
${WOMEN}    xpath=//*[@id="ui-id-4"]/span[2]
${TOPS}    xpath=/html/body/div[2]/div/div/div[2]/nav/ul/li[2]/ul/li[1]/a/span[2]
${BOTTOM}    xpath=//*[@id="ui-id-10"]/span[2]
${HOODIES&SWEATSHIRT}    xpath=//*[@id="ui-id-12"]/span
${PANTS}    xpath=//*[@id="ui-id-15"]/span
${SHORTS}    xpath=//*[@id="ui-id-16"]/span

*** Test Cases ***
[Setup]  Run Keywords  Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    
Luma Test
    Maximize Browser Window
    Set Selenium Implicit Wait    30 seconds
    
    # Creation d'un compte utilisateur
    #Create account    ${FIRSTNAME}    ${LASTNAME}    ${USERNAME}     ${PASSWORD}
    #Logout

    # Identification utilisateur
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    5 seconds
    # Capture Page Screenshot    screenshotsLuma/login.png

    # Ajout d'éléments dans le panier
    Items to cart    ${WOMEN}    ${TOPS}    ${BOTTOM}    ${HOODIES&SWEATSHIRT}    ${PANTS}    ${SHORTS}
    # Capture Page Screenshot    screenshotsLuma/cartItems.png

    # Modification du panier
    Cart edit
    # Capture Page Screenshot    screenshotsLuma/cartEdit.png

    # Réinitialisation du panier
    Empty cart    
    # Capture Page Screenshot    screenshotsLuma/emptyCart.png

    #Logout
    Logout

*** Keywords ***
# Create account
#     [Arguments]    ${FIRSTNAME}    ${LASTNAME}    ${USERNAME}     ${PASSWORD}
#     Go To    https://magento.softwaretestingboard.com/customer/account/create/
#     Click Element    link=Create an Account
#     Click Element    id=firstname
#     Input Text    id=firstname    ${FIRSTNAME}
#     Click Element    id=lastname
#     Input Text    id=lastname    ${LASTNAME}
#     Click Element    id=email_address
#     Input Text    id=email_address    ${USERNAME}
#     Click Element    id=password
#     Input Text    id=password    ${PASSWORD}
#     Input Text    id=password-confirmation    ${PASSWORD}
#     Click Button    xpath=//form[@id='form-validate']/div/div/button

login
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Go To    https://magento.softwaretestingboard.com/customer/account/
    Click Element    id=email
    Input Text    id=email    ${username}
    Click Element    id=pass
    Input Text    id=pass    ${password}
    Click Button    id=send2

Items to cart
    [Arguments]    ${WOMEN}    ${TOPS}    ${BOTTOM}    ${HOODIES&SWEATSHIRT}    ${PANTS}    ${SHORTS}
    Go To    https://magento.softwaretestingboard.com/
    #add --- Cassia Funnel Sweatshirt
    Mouse Over    ${WOMEN} 
    Mouse Over    ${TOPS}
    Click Element   ${HOODIES&SWEATSHIRT}
    Wait Until Page Contains Element    //*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[5]
    Mouse Over    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[5]
    Click Element    xpath=/html/body/div[2]/main/div[3]/div[1]/div[4]/ol/li[5]/div/div/div[2]/div[1]/div/div[1]
    Click Element    xpath=//*[@id="option-label-color-93-item-59"]
    Click Button    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[5]/div/div/div[3]/div/div[1]/form/button
    Wait Until Page Contains Element    ${WOMEN}

    #add --- Diana Tights
    Mouse Over    ${WOMEN} 
    Mouse Over    ${BOTTOM}
    Click Element    ${PANTS}
    Wait Until Page Contains Element    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[8]
    Mouse Over    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[8]
    Click Element    xpath=/html/body/div[2]/main/div[3]/div[1]/div[4]/ol/li[8]/div/div/div[3]/div[1]/div/div[1]
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[8]/div/div/div[3]/div[2]/div/div
    Click Button    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[8]/div/div/div[4]/div/div[1]/form/button
    Wait Until Page Contains Element    ${WOMEN}

    #add --- Ana Running Short
    Mouse Over    ${WOMEN} 
    Mouse Over    ${BOTTOM}
    Click Element    ${SHORTS}
    Wait Until Page Contains Element    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[3]
    Mouse Over    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[3]
    Click Element    xpath=/html/body/div[2]/main/div[3]/div[1]/div[4]/ol/li[3]/div/div/div[3]/div[1]/div/div[1]
    Click Element    xpath=/html/body/div[2]/main/div[3]/div[1]/div[4]/ol/li[3]/div/div/div[3]/div[2]/div/div[3]
    Click Button    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[3]/div/div/div[4]/div/div[1]/form/button
    Wait Until Page Contains Element    ${WOMEN}
    
Cart edit
    Go To    https://magento.softwaretestingboard.com/checkout/cart/
    Wait Until Page Contains    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[1]/table/tbody[3]/tr[1]/td[3]/div/div
    Click Element    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[1]/table/tbody[3]/tr[1]/td[3]/div/div/label/input
    Clear Element Text    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[1]/table/tbody[3]/tr[1]/td[3]/div/div/label/input
    Input Text    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[1]/table/tbody[3]/tr[1]/td[3]/div/div/label/input    2
    Click Element    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[2]/button[2]/span

Empty cart
    ${NB_ITEMS}    Get Element Count   xpath=//tbody[@class='cart item']
    Log To Console    Nombre d'items différents : ${NB_ITEMS}
    IF  ${NB_ITEMS}>0
        Click Element    xpath=/html/body/div[2]/main/div[3]/div/div[3]/form/div[1]/table/tbody[1]/tr[2]/td/div/a[3]
    END
    
Logout
    Click Element    xpath=//button[@type='button']
    Click Element    link=Sign Out
    

