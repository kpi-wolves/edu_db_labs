# Модель прецедентів

## 1. Діаграма прецендентів

<center style="
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml
    actor "Гість" as Guest #eeeeaa
    actor "Користувач" as User #eeeeaa
    actor "Адміністратор" as Admin #eeeeaa
    
    usecase "<b>Реєстрація</b>" as UC_1
    usecase "<b>Авторизація</b>" as UC_2
    usecase "<b>Перегляд історії запитів</b>" as UC_3
    usecase "<b>Створення нового запиту на аналіз</b>" as UC_4
    usecase "<b>Видалення запиту на аналіз</b>" as UC_5
    usecase "<b>Видалення облікового запису</b>" as UC_6
    usecase "<b>Перегляд даних для відладки</b>" as UC_7
    usecase "<b>Перегляд облікового запису користувача</b>" as UC_8
    
    Guest -u-|> User
    User -u-|> Admin 
    Guest --> UC_1   
    Guest --> UC_2
    User --> UC_3
    User --> UC_4
    User --> UC_5
    Admin --> UC_6
    Admin --> UC_7
    Admin --> UC_8
@enduml

**Діаграма прецедентів**

</center>

## 2. Use Cases для гостя

<center style="
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml
    actor "Гість" as Guest #eeeeaa
    
    usecase "<b>Реєстрація</b>" as REGISTRATION
    usecase "<b>Авторизація</b>" as AUTHORIZATION
    usecase "<b>Відновити пароль</b>" as RESTORE_PASSWORD
    
    Guest --> REGISTRATION   
    Guest --> AUTHORIZATION
    RESTORE_PASSWORD ...> AUTHORIZATION: extends
@enduml

**Use Cases для гостя**

</center>

## 3. Use Cases для адміністратора

<center style="
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml
    actor "Адміністратор" as Admin #eeeeaa
    
    usecase "<b>Видалення облікового запису</b>" as REMOVE_USER
    usecase "<b>Перегляд даних для відладки</b>" as VIEW_REQUEST_DEBUG_DATA
    usecase "<b>Перегляд облікового запису користувача</b>" as VIEW_USER_ACCOUNT
    
    Admin --> REMOVE_USER   
    Admin --> VIEW_REQUEST_DEBUG_DATA
    Admin --> VIEW_USER_ACCOUNT
@enduml

**Use Cases для адміністратора**

</center>

## 4. Use Cases для клієнта 

<center style="
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml
    actor "Клієнт" as User #eeeeaa
    
    usecase "<b>Перегляд історії запитів</b>" as VIEW_HISTORY
    usecase "<b>Створення нового запиту на аналіз</b>" as MAKE_REQUEST
    usecase "<b>Видалення запиту на аналіз</b>" as DELETE_REQUEST
    
    User --> VIEW_HISTORY   
    User --> MAKE_REQUEST
    User --> DELETE_REQUEST
@enduml

**Use Cases для клієнта**

</center>

## 5. Сценарії
