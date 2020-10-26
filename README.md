# Quick-API-REST-rails-with-docker-and-compose
---
Hi! maybe you need to start a API REST with rails and you plan to use docker and docker-compose and haven't idea how to start, well maybe i can help you. In this repository you will find a very quick version of a REST API with these requirements and i'm gonna explain you how it works and the modifications to be made if you add a new model.

## This API doesn't consider session handling.

## Before start

- First you need to have docker and docker-compose installed in your computer, if you don't know how do it i recommend that you visit the official docker site and review the installation tutorials for [docker](https://docs.docker.com/engine/install/ubuntu/#installation-methods) and [docker-compose](https://docs.docker.com/compose/install/).
- You need a software for the request. Postman is an option or Talend API Tester is an extension of chrome and you can use too.
- If you want start you own RoR application with compose, you can read this official [tutorial](https://docs.docker.com/compose/rails/). But if you want use this app read the ***Steps if you clone this repo*** section.


## Steps if you clone this repo
First you need run the next command in the project folder in the console:
```
 docker-compose build 
 ```
 This command build the docker image of the project, with this you will see that many things will be installed such as ruby gems, it will request everything you need to work on your computer. Now we need create a db in postgress, beacause this webpack use postgress, so you need run this command in your console:
 ```
 docker-compose run web rails db:create
 ```
 After creating the database, we need to migrate own models. What is a migration? a migration is a way to modify your db, tables, with the models that you created in your application. For example, in this repo if you check the models folder in app/models you can find a file with the name animal.rb. This file contain all animal model information, and when you migrate, tables with this information are created in your database. 
 The command for migrate is:
  ```
 docker-compose run web rails db:migrate
 ```
 We are ready for use the API REST, but first we need to run this command:
   ```
 docker-compose up
 ```
 In your browser visit
 ```
 http://localhost:3000/
 ```
 If says ***Yay! You’re on Rails!*** the installation is done.
 
 Now in postman or the software of your preferences we are gonna do a request. In a REST API we can do differents request like get, post, delete or patch. In this explanation we are gonna do one of each.
 
 In your request software you need to use this url
 ```
 http://localhost:3000/api
 ```
 # ***But why?***
 The reason is that for it to work as an api we needed to make some changes in the routes of the applications. 
 routes? yes, routes. The routes are the "directions" that the application has for do different things. For example get information about a model.
 
 Now in the request software we are gonna do this request:
 ```
GET http://localhost:3000/api/animals
 ```
 You need to select GET in the methods and in the url use ***http://localhost:3000/api/animals***
 
 The response will be [], why? because you don't have any animal created in your db. So, now we are gonna create one.
 
 You need to select POST method and use this url ***http://localhost:3000/api/animals*** 
  ```
POST http://localhost:3000/api/animals
 ```
 and  we need to write a json in body. The json is for send information to the API, and this look like:
  ```
{
    "animal":
    {
        "name": "pepe"
    }
}
 ```
 The first argument is for references at model (animal) and the "name" is the unique attrbute of animal model, you can check this in app/models/animal.rb or db/schema.rb. 
 
 Now press the button for send the request. The response will look like
  ```
 {
    "id": 1,
    "name": "pepe",
    "created_at": "2020-10-26T08:16:10.184Z",
    "updated_at": "2020-10-26T08:16:10.184Z"
}
  ```
The id is the id in the table of your new animal, you can also see the name you gave it and the time it was created. And you can create all animals what you want, but first we are gonna do the GET request. Now the answer must contain the animal you created. 

So, we are gonna repeat the GET request:
 ```
GET http://localhost:3000/api/animals
 ```
 And the response:
 ```
 [
    {
    "id": 1,
    "name": "pepe",
    "created_at": "2020-10-26T08:16:10.184Z",
    "updated_at": "2020-10-26T08:16:10.184Z"
    }
]
 ```
 Now we have the animal, but now we are gonna create another animal.
   ```
POST http://localhost:3000/api/animals
 ```
 
   ```
{
    "animal":
    {
        "name": "firulais"
    }
}
 ```
 The response:
  ```
 {
    "id": 2,
    "name": "firulais",
    "created_at": "2020-10-26T08:24:16.215Z",
    "updated_at": "2020-10-26T08:24:16.215Z"
}
  ```
Now you can repeat the GET request and the response must be:

 ```
 [
    {
    "id": 1,
    "name": "pepe",
    "created_at": "2020-10-26T08:16:10.184Z",
    "updated_at": "2020-10-26T08:16:10.184Z"
    },
    {
    "id": 2,
    "name": "firulais",
    "created_at": "2020-10-26T08:24:16.215Z",
    "updated_at": "2020-10-26T08:24:16.215Z"
    }
]
 ```
Also you can do a GET request with a specific animal id, it look like:
 ```
GET http://localhost:3000/api/animals/1
 ```
 response:
  ```
 {
    "id": 1,
    "name": "pepe",
    "created_at": "2020-10-26T08:16:10.184Z",
    "updated_at": "2020-10-26T08:16:10.184Z"
}
 ```
 
 Delete method:
 
For this request we need to use a specific id of an animal, and the request is:
 ```
DELETE http://localhost:3000/api/animals/1
 ```
 Press the button to send request.
 response:
  ```
 {}
 ```
 and if you do the GET request:
 
  ```
GET http://localhost:3000/api/animals
 ```
 
 response:
 
  ```
 [
    {
    "id": 2,
    "name": "firulais",
    "created_at": "2020-10-26T08:24:16.215Z",
    "updated_at": "2020-10-26T08:24:16.215Z"
    }
]
 ```
 
 The animal with id 1 was deleted.
 
 PATCH method:
 
 This method is used for modification in an animal created, for example we are gonna change the name of firulais for shrek. For this is necessary to specify the id of the animal to modify, in this case firulais has id 2.
 
```
PATCH http://localhost:3000/api/animals/2
 ```

 body request:
```
{
    "animal":
    {
        "name": "shrek"
    }
}
 ```
 response:
 ```
 {
    "id": 2,
    "name": "shrek",
    "created_at": "2020-10-26T08:24:16.215Z",
    "updated_at": "2020-10-26T08:34:19.897Z"
}
 ```
 You can check that the updated_at is different now.
 And if you do GET request:
```
GET http://localhost:3000/api/animals
```
 response:
 ```
 [
     {
        "id": 2,
        "name": "shrek",
        "created_at": "2020-10-26T08:24:16.215Z",
        "updated_at": "2020-10-26T08:34:19.897Z"
    }
]
 ```
 # Now, how is it possible to use this app like an API REST? 
 You need to change three files:
 - application_controller.rb
 - routes.rb
 - animals_controller.rb
 
## application_controller.rb
path: app/controllers/
In this file you need to add this line:
 ```
    protect_from_forgery with: :null_session
 ```
 this method is for protect your API and how we don't have session is necessary use :null_session.
 
 # routes.rb
 Is necessary add this lines inside the 
 ```
 scope :api do
    resources :animals
 end
 ```
 This is the reason that the url is: 
  ```
 http://localhost:3000/api
 ```
And the another routes always uses /api. The reason is the scope.

## animals_controller.rb
And finally we need to change the the way the controller methods respond and handle it to respond as json.

For example for index method:

### Before
  ```
 def index
    animals = Animal.all
  end
 ```
 ### Now
```
 def index
    animals = Animal.all
    render json: animals
  end
```
With this change the repsonse now is json. The changes in the other methods you can check the animals_controller.rb
 
### And that is. If you add a new model you must modify the routes.rb, add the lines in the scope and change his model controller to respond as json.
 


