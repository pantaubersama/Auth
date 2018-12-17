# README
## Pantau Bersama Auth

##### Setup
- `git clone git@git.extrainteger.com:pantau-group/API/pantau-bersama-auth.git`
- setup your database (postgresql)
- create env variable files (.env.development , .env.test)
    - `.env.development`
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=auth_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```

 - `.env.test` 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=auth_test
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```
   
- `$ bundle install`
- `$ rails db:create db:migrate`
- `$ rails s`
- go to [`http://localhost:3000/doc`](http://localhost:3000/doc)

#### make sure all success installed
- [`http://localhost:3000/auth/v1/infos`](http://localhost:3000/auth/v1/infos)
