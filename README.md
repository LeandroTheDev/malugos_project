# Malugos Project
Making a aplications for malugos.

The idea behind it is to make an application 
for the company where I am working, just for 
training purposes, I will be using the MYSQL 
database to save the data and loging into the aplication.

Observation: this is a brazilian company, so the applications will be all in "portugues-brasil"

# Packages using in this project

- provider: ^6.0.4
- http: ^0.13.5
- mysql1: ^0.20.0
- carousel_slider: ^4.1.1
- shared_preferences: ^2.0.15
- auto_size_text: ^3.0.0

# How does it work?

The application provides an authentication system based on a database, 
it will pull email and password, if you hit you can enter the application 
and have your personal settings saved.

The products, images, prices, are saved in the server's database,
there will be columns for each type of information.

Made in such a way that to change the quantity of products, 
or any product information, you just need to change it inside 
the database, making the application not need daily maintenance.

# Database works

The database will have 1 Data Bank and 3 importants table.

The applications works behind this database, see the [Database Configuration](https://github.com/LeandroTheDev/malugos_project/wiki/Database-Configuration) for more informations to configure.

> by: LeandroTheDev