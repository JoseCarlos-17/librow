# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Criar o usuário postgresql
- sudo su postgres -c psql
- create user postgres with password 'postgres'

criar o banco de dados no postgresql e dar todos os privilégios para ele

- create database rails_with_postgres_development
- create database rails_with_postgres_development_test
- grant all privileges on database projectname_development to postgres
- grant all privileges on database projectname_test to postgres


alterar a senha do usuário postgresql

- \password postgres
- Enter new password: <new-password>
- \q