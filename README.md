# README
## Pantau Bersama Auth

##### Setup
- `git clone git@git.extrainteger.com:pantau-group/API/pantau-bersama-auth.git`
- setup your database (postgresql)
- create env variable files (.env.development , .env.test) from .env.example
- `$ bundle install`
- `$ rails db:create db:migrate seed:migrate`
- `$ rails s -p 4000`
- go to [`http://localhost:4000/doc`](http://localhost:4000/doc)

#### make sure all success installed
- [`http://localhost:4000/auth/v1/infos`](http://localhost:4000/auth/v1/infos)
