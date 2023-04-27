# Реалізація інформаційного та програмного забезпечення

## RESTfull сервіс для управління даними

<style>
  .codeFile {
    border: solid 1px; 
    border-bottom-color: transparent; 
    padding: 8px; 
    background-color: white; 
    font-family: "Menlo", monospace;
  }
</style>

<div class="codeFile">entity/User.ts</div>

```js
import { Entity, BaseEntity, Column, PrimaryGeneratedColumn, Unique } from "typeorm";

@Entity("users")
@Unique(["email"])
export class User extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  email: string;

  @Column()
  password: string;

  @Column()
  userName: string;

  @Column()
  roleId: number;
}
```
