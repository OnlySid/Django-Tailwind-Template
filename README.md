# Django + Tailwind CSS Starter Kit
This is a starter template for Django + Tailwind CSS. There are many ways to configure such an environment but I've found this to be the easiest.


## Getting Started
This tutorial will cover setting up a base project with Django, Tailwind and MySQL but any of the steps can be swapped out with technologies of your choosing.

### Prerequisites
Here's what needs to be installed before we are able to continue:
- Python & Pip
- NodeJS
- MySQL (PostgreSQL, MariaDB, Oracle, SQLite) (optional)

### Setup
This workflow requires a virtual environment to handle dependencies properly. First, we'll enter a new virtual environment and then install everything we need. Enter the following into the terminal at this file's base directory.

```
pip install pipenv
```
```
pipenv shell
```
This will take you through a setup process.

```
sh setup.sh
```
This completes the Tailwind and Django setup.


## Configuring for MySQL
Before attempting any of this, ensure you have mysql installed and have a database, user and a password set up.

### Setup

Within settings.py, look for the object labelled "DATABASES" and enter the following information, replacing values with your own:
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'DB_NAME',
        'USER': 'DB_USER',
        'PASSWORD': 'DB_USER_PASSWORD',
        'HOST': 'localhost',
        'PORT': '3306'
    }
}
```
To use this as the default Django database for the framework, admins and any models created through Django, we must run the following command:
```
pipenv run migrate
```
This creates the necessary tables in our database to use django admin. Next, we will handle creating our own tables using Django's "Models".

### Django Admin

Django comes with a pre-built admin area, made accessible at /admin. To access this area, we must first create a super user via the following command:
```
python manage.py createsuperuser
```
Follow the steps outlined in the terminal then spin up the server and head to /admin. To start the server, run:
```
pipenv run server
```

### Creating Database Tables

Within a file in your app's main directory called 'models.py', we can do the following to create a blueprint (model) of a 'customer' table.
```
from django.db import models

class Customer(models.Model):
    created_at = models.DateTimeField(auto_now_add = True)
    first_name = models.CharField(max_length = 50)
    last_name = models.CharField(max_length = 50)
    email = models.EmailField(max_length = 254)
    phone = models.CharField(max_length = 15)

    # Identify customer by name when object created via model is printed
    def __str__(self):
        return(f"{self.first_name} {self.last_name}")
```
Now, run makemigrations to let Django create the necessary SQL to perform the creation of this database table:
```
pipenv run makemigrations
```
Then, run the migrate command again to run the SQL created by Django (hint: you can actually view this SQL by looking for the file created in a "migrations" directory):
```
pipenv run migrate
```
This will have created a "customers" table in your default database. It also automatically adds a primary key in the form of an index too.

You can, optionally, add this model to your admin area by adding the following to 'admin.py':
```
from .models import Customer

admin.site.register(Customer)
```
To use your customer database information within an HTML template, pass the model to views.py within the function you wish to view the content through using something like this:
```
customers = Customer.objects.all()
```
Then, pass it to the render by returning the following:
```
return render(request, 'page.html', {'customers': customers})
```
Now that you have a model, you can create views, forms and much more using Django fairly easily! For more information, [follow the steps provided here](https://docs.djangoproject.com/en/4.2/topics/forms/modelforms/).


## Using Tailwind

Tailwind is currently set up to look at any html file within the templates directory. You can add any other files you may wish to watch in the tailwind.config.js file.

This config file contains some base settings to handle large screen-size responsiveness and provides a default colour sheme.

To start watching for changes, run:
```
pipenv run watch
```
Adding tw classes to elements and saving the file will now generate the CSS in static/src/output.css.

Within the same src directory, we have a 'style.css' file which is also being watched by default. Using '@apply'-style Tailwind CSS overrides here works and also generates changes to output.css.

To bundle and minify output.css, ready for production, run:
```
pipenv run build
```


## Deployment

### Server Requirements
Your server will need the following:
- Apache
- NGINX (To set up a reverse proxy)

Further instructions for deployment coming soon.