# Реалізація інформаційного та програмного забезпечення

## RESTfull сервіс для управління даними

<style>
  .codeFile {
    background-color: #EEE;
    border-bottom: solid 1px #BDBDBD;
    font-style: italic; 
    padding: 8px 16px; 
    font-family: "Menlo", monospace;
  }
</style>

<div class="codeFile">entity/User.ts</div>

```ts
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

<div class="codeFile">controller/UserController.ts</div>

```ts
import { Database } from "../database";
import { Repository, QueryFailedError, EntityNotFoundError } from "typeorm";
import { User } from "../entity/User";
import { Request, Response } from "express";

type Handler = (req: Request, res: Response) => Promise<void>;

export class UserController {
  private repository: Repository<User>;

  constructor(database: Database) {
    this.repository = database.getRepository(User);
  }

  errorHandler = (e: Error, res: Response) => {
    switch (e.constructor) {
      case EntityNotFoundError:
        res.status(404).send();
        break;

      case QueryFailedError:
        res.status(400).send();
        break;
      
      default:
        res.status(500).send();
        break;
    }
  }

  find: Handler = async (_, res) => {
    const users = await this.repository.find();
    res.json(users);
  }
  
  findOne: Handler = async (req, res) => {
    try {
      const user = await this.repository.findOneBy({
        id: Number(req.params.id),
      });
      if (user === null) {
        throw new EntityNotFoundError(User, null);
      }
      res.json(user);
    } catch (e) {
      this.errorHandler(e, res);
    }
  }

  create: Handler = async (req, res) => {
    try {
      const user = this.repository.create(req.body);
      const results = await this.repository.save(user);
      res.json(results);
    } catch (e) {
      this.errorHandler(e, res);
    }
  }

  remove: Handler = async (req, res) => {
    try {
      const results = await this.repository.delete(req.params.id);
      res.json(results);
    } catch (e) {
      this.errorHandler(e, res);
    }
  }

  update: Handler = async (req, res) => {
    try {
      const user = await this.repository.findOneBy({
        id: Number(req.params.id),
      });
      this.repository.merge(user, req.body);
      const results = await this.repository.save(user);
      res.send(results);
    } catch (e) {
      this.errorHandler(e, res);
    }
  }
}
```

<div class="codeFile">database.ts</div>

```ts
import { DataSource, EntityTarget } from "typeorm";
import { SnakeNamingStrategy } from "typeorm-naming-strategies";
import { User } from "./entity/User";

export class Database {
  private origin: DataSource;

  constructor() {
    this.origin = new DataSource({
      type: "mysql",
      username: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      entities: [User],
      namingStrategy: new SnakeNamingStrategy(),
    });
  }

  async connect() {
    return await this.origin.initialize();
  }

  getRepository<T>(repositoryClass: EntityTarget<T>) {
    return this.origin.getRepository(repositoryClass);
  }
}
```

<div class="codeFile">index.ts</div>

```ts
require("dotenv").config();
import "reflect-metadata";
import * as express from "express";
import { Database } from "./database";
import { UserController } from "./controller/UserController";

(async () => {
  const db = new Database();
  await db.connect();

  const userController = new UserController(db);

  const app = express();
  app.use(express.json());

  app
    .route("/users")
    .get(userController.find)
    .post(userController.create);

  app
    .route("/users/:id")
    .get(userController.findOne)
    .delete(userController.remove)
    .put(userController.update);

  app.listen(80);
})();
```
