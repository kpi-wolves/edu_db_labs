# Проєктування бази даних

## Модель бізнес-об'єктів

@startuml

entity Research
entity Research.id
entity Research.results
entity Research.isDone

entity User
entity User.email
entity User.password
entity User.id
entity User.userName

entity Role
entity Role.displayText
entity Role.id

User *-- User.email
User *-- User.password
User *-- User.id
User *-- User.userName

Role *-- Role.id
Role *-- Role.displayText

Research *-- Research.id
Research *-- Research.results
Research *-- Research.isDone
Research *-- Research.debuggerData

User "0,*" -- "1,1" Role 
User "1,1" -- "0,*" Research

@enduml

## ER-модель
@startuml 

entity Role  {
  id: INT 
  displayText: TEXT 
}

entity User { 
  id: INT 
  email: TEXT 
  password: TEXT 
  userName: TEXT  
}

entity Research  {  
  id: INT  
  results: OBJECT
  debuggerData: OBJECT
  isDone: BOOLEAN
}

Role "1, 1" <-- "0, *" User  
User "1, 1" <-- "0, *" Research

@enduml

## Реляційна схема

<center style="margin-top: 16px">
  <img style="max-width: 420px" alt="" src="./img/relationScheme.png" />
</center>
