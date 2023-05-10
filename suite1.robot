*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           String

*** Variables ***
${mName}          The Shawshank Redemption



*** Test Cases ***
TC1
    Open Browser    https://www.imdb.com    Edge
    Input Text    id=suggestion-search    ${mName}
    Click Button    id=suggestion-search-button
    @{elements}=    Get WebElements    css=.ipc-metadata-list-summary-item__t
    ${my_list}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Append To List    ${my_list}    ${text}
        Should Contain    ${text}    ${mName}    ignore_case=True
    END
    ${first_element}    Get From List    ${my_list}    0
    Should Match    ${first_element}    ${mName}    ignore_case=True

TC2
    Open Browser    https://www.imdb.com    Edge
    Maximize Browser Window
    Sleep    2s
    Click Element    id=imdbHeader-navDrawerOpen
    Sleep    2s
    Click Link    link=Top 250 Movies
    @{elements}=    Get WebElements    css=.titleColumn
    ${my_list}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Append To List    ${my_list}    ${text}
    END
    ${length}    Get Length    ${my_list}
    Should Be Equal As Integers    ${length}    250
    ${first_element}    Get From List    ${my_list}    0
    Should Contain    ${first_element}    ${mName}    ignore_case=True


TC3
    Open Browser    https://www.imdb.com    Edge
    Maximize Browser Window

    Click Element    Xpath=//*[@id="nav-search-form"]/div[1]/div/label

    Click Link    Link=Advanced Search

    Click Link    Link=Advanced Title Search
    Click Element    id=title_type-1
    Click Element    id=genres-1
    Input Text    Xpath=//*[@id="main"]/div[3]/div[2]/input[1]    2010-01-01
    Input Text    Xpath=//*[@id="main"]/div[3]/div[2]/input[2]    2020-01-01
    Click Button    Search
    @{elements}=    Get WebElements    css=.ratings-bar
    ${my_list}    Create List
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        ${split_string}    Split String    ${text}    ${SPACE}
        ${temp}    Convert To Number    ${split_string[0]}
        Append To List    ${my_list}    ${temp}
    END
    ${Clist}    Copy List    ${my_list}
    Sort List     ${Clist}
    reverse list     ${Clist}
    Lists Should Be Equal     ${Clist}    ${my_list}






