# README
## Pantau Bersama Auth

##### Setup
- `git clone git@git.extrainteger.com:pantau-group/API/pantau-bersama-auth.git`
- setup your database (postgresql)
- create env variable files (.env.development , .env.test) from env.example
- `$ bundle install`
- `$ rails db:create db:migrate seed:migrate`
- `$ rails s -p 4000`
- go to [`http://localhost:4000/doc`](http://localhost:4000/doc)

#### HTTP Authentication

Check it out in your `.env.development`

```
Username : admin
Password : admin
```

#### make sure all success installed
- [`http://localhost:4000/v1/infos`](http://localhost:4000/v1/infos)
