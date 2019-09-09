# Django: Tips and good practices

**Abstract**: The Django framework save time and effort and help to create apps and REST APIs with maintainable code. This blog gives some practical examples of what to do and what not to do when you code in Python using Django.  

**Summary**: This blog explains why good code structure and configuration is important in any environment. It describes Django’s main concepts and some easy ways to implement web app functionalities with existing tools that solve general problems. I also recommend good practices for efficiency and APIs and packages for session management and testing. Finally, I describe some things that, from my experience, are best to avoid. 

## Start with good code
Like all software developers, I want to create maintainable code. It’s not just for me but also for my partners. It feels good to know that the programs you use or maintain have good code quality and what you construct is easy to change, reuse, update, review, and so on.  

I recently learned to code in Python programming language by using the Django and Django REST frameworks. Now I want to share some tips and good practices for developing REST APIs with those technologies. When I face a programming problem, I first try to solve it. Then I look for an even better way to reach the solution. I write that information down and store it, so I can share what I learn with others. This blog is compiled from the notes I took when I learned Django. My goal is to help others learn Django too. It’s also a good place to start for people who just want to learn code.

## The Django and Django REST frameworks
Django is a solid framework for developing web apps with Python language. It’s fast, secure, scalable, and well documented. If you want to build REST APIs, you can combine Django with the Django REST framework to generate a base project in just a few seconds. These webpages tell you more:  
+ [Django](https://www.djangoproject.com)
+ [Django REST](https://www.django-rest-framework.org)

> Tip: Don’t reinvent the wheel.  

Any teacher of computer science might say to students: Don't reinvent the wheel. For example, you might run into a problem when you’re coding that already has a documented solution. It's better and faster to take advantage of a known solution than to spend time creating a new one. There are many open source projects that perform common tasks to solve general problems. You can use them for free on your apps, and you can also make contributions and propose improvements!
So if you want to create a REST API, there’s no need to reinvent the wheel. Use the Django frameworks to design that kind of app, and use the maintained tools to attack the common problems you encounter.  

## Scaffolding and configuration structure
As I said, anyone can quickly create a base project with Django frameworks. Detailed commands for that are in Django’s documentation. It’s a good practice to build a structure that increases maintainability. Then we can easily create a different configuration for each environment we use. Some examples are development, production, and testing. 
By default, Django generates a settings.py file for all the configurations of a project. That means several if's separate each part for each environment. This way is better:

+ Keep the general configuration, which is common to all environments, in a base file.
+ Then create different files that correspond to each of the different environments.

In this simple example, I change the file *settings.py* in a project named **example_project** for a settings folder containing the next files:

+ \_\_init\_\_.py
+ base.py
+ development.py
+ production.py

The \_\_init\_\_.py file defines which configuration to use, depending on the environment:

``` python
import os
import importlib

# by default use development
ENV_ROLE = os.getenv('ENV_ROLE', 'development')

env_settings = importlib.import_module(f'example_project.settings.{ENV_ROLE}')

globals().update(vars(env_settings))
    
# import local settings if present
try:
    from .local import *  # noqa
except ImportError:
    pass
```

With the \_\_init\_\_.py file, I define an environment variable named **ENV_ROLE** for each environment. The value is the name of the configuration file that corresponds to that environment. For example, in my production environment, I create the ENV_ROLE variable with the `production` value. Then I use the *production.py*  file to set the specific configuration in the production environment.

By creating environment variables, you can separate the configurations of the different environments. Examples are different databases for development and production or different allowed hosts. In the *base.py* file, don’t forget to set the common configurations for all environments like INSTALLED_APPS, MIDDLEWARE, and TEMPLATES.

### One project, multiple apps
Several applications might exist in a single Django project. In Django context, an app is a set of related functionalities and models. Some more good practices are to build scaffolding that shows where the apps are in order to define standard locations for general functions and classes. In short, we want an orderly and easy-to-maintain structure.

This code creates a suggested scaffolding:

```
project_name
|
|__project_name (Put all the settings for the app here.)
|    |__ __init__.py
|    |__settings
|          |__ __init__.py
|          |__ base.py
|          |__ development.py
|          |__ staging.py
|          |__ production.py
|          ...
|    |__wsgi.py
|    |__asgi.py(optional)
|    |__urls.py
|    ...
|
|__templates (These general templates are loaded last in the application.)
|
|__api
|  |__ __init__.py
|  ...
|  |__ urls.py (Use this file to route the apps located under the applications folder.)
|
|__applications
|   |__ __init__.py
|   |__app1
|    ... |__models.py (Split the folder and import models in __init__ if necessary.)
|        |__views.py
|        |__serializers.py
|        |__urls.py
|        |__test
|        |   ...  
|        |__templates (Optional and not present if the project is API only.)
|        |
|        |__api.py (Optional and not present if the project is API only.)
|        ... (Add more files if they’re needed.)
|
|__utils
|   |__util_1.py
|   |__util_2.py
...
```

This structure isn’t mandatory, but it’s a good way to increase maintainability. In my suggested scaffolding, there’s a special app, named api. In api, I define the routing of the other apps in the applications folder. In the utils folder, I also define the project’s general functions and utilities.

## Main concepts of Django and Django REST
To work with Django and Django REST, it’s important to understand these concepts:

+ **Model** classes provide an object-relational map (ORM) for the underlying database. A model is mapped to a table in the database. You can query the databases without any SQL programming. With models, it’s easy to define tables and relationships between them.
+ **Views** are in charge of the process of requests. They function as controllers. You can implement them in many ways, such as functions or classes.
+ **Serializer** classes provide control of data types and structures of requests and responses. I like to define them as interfaces for the backend of the web app.
+ **Templates** are files with static and dynamic content. They’re made up of some static code and other elements that depend on the context.

There are many ways to implement the functionalities of a REST API by using the Django frameworks. There are also many ways to implement views and serializers. For general design and any bugs you might run into, I recommend the generic tested and maintained solutions, such as Generic views. 

### Generic views
The Django REST framework has generic views that perform common tasks related to the model instances. Some examples are retrieve information, create, destroy, list, and update. With [Django’s generic views](https://www.django-rest-framework.org/api-guide/generic-views), you only need to define the class view as a child of the generic view, depending on your needs. The rest is solved by the framework. 
To learn how to implement the generic view functionality to generate a list of instances for a given model, let’s look at these classes:

``` python
from django.db import models

class Person(models.Model):
    name = models.CharField(max_length=50)
    age = models.IntegerField() 
```

Now we create a serializer to see the details of an instance of that model:

``` python
from rest_framework import serializers
from applications.people.models import Person

class PersonDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = ('name', 'age')
```

Next, we define a view that lists all the instances:
``` python
from rest_framework import generics
from applications.people.serializers import PersonDetailSerializer

class PeopleListView(generics.ListCreateAPIView):
    queryset = Person.objects.all()
    serializer_class = PersonDetailSerializer
```

And that's it! It only takes a few lines to create generic view functionality. In the `queryset` attribute, we tell the view which instances we want to list. In `serializer_class`, we select the data structure. Everything else is already solved.

### Customize functions
The many generic views in the Django documentation meet a wide range of functionality needs. Some examples are `CreateAPIView`, `ListAPIView`, `RetrieveAPIView`, and `RetrieveDestroyAPIView`. But what if you want to customize the functions and change the default behavior? You can redefine `get`, `post`, `put`, `delete`, and other methods. You can also use the mixins to redefine the methods and specific functions like `create`, `update`, `destroy`, and others. The generic views and serializers aren’t required, but they can simplify a lot work. Serializers also cover some issues related to requests and responses, so we don't have to worry about them.

### Data validation
The next good practice I want to share is how to locate the validation of incoming data. For example, you might have values for the fields of serializers in your web app. You want to run some checks on them when a new request comes into the REST API. In the `PersonDetailSerializer`, you can do a field-level validation that just defines a function named `validate_<field_name>`.

Let's add a function in the serializer:

``` python
pythonclass PersonDetailSerializer(serializers.ModelSerializer):

    def validate_age(self, age):
        if age < 0:
            raise serializers.ValidationError('Age must be a positive number.')
        return age    

    class Meta:
        ...
```

### Complex validations
Sometimes you need to define a more complex validation inside the serializer class. An example is validating constraints between fields. A good way to do that is with the validate function: `validate(self, data)`.
In summary, serializers are a good way to validate incoming data. In the previous example, `PersonDetailSerializer` is attached to the Person model. So by default, it does basic validation related to the model. For example, if the incoming name length is bigger than 50 characters, then the serializer raises an exception, because the maximum length was defined in the model. You don’t need to make that explicit in the serializer. With Django, you can also define serializers that aren’t attached to models, nest serializers and relationships between them, and more. Serializers are very powerful.

### Templates
Finally, let’s talk about templates. As I mentioned, they’re great for generating dynamic code in Django. For example, template files can be used by the project frontend or to send emails.

> Tip: Be aware of the order of apps defined in the project configuration, INSTALLED_APPS list.

It’s important to take order into account because it’s common for several apps to provide different versions of the same resource like a template or static file. If that happens, Django’s default behavior is to first check in the templates folder of the first app in the list. But that can cause problems. Order matters. By knowing this, we can change the order of the INSTALLED_APPS according to our needs. Or we can just explicitly define the desired paths for specific resources. For a configuration example, read the Django docs.

## Session management
Most web applications have users and authentication methods. In the spirit of don't reinvent the wheel, I recommend using an existing customizable solution for session management: django-rest-auth. You can easily integrate this set of REST API endpoints with your project. It resolves user registration, sign in, and sign out, as well as social account integration. Just use the provided endpoints and customize the models and functions to adapt them to your needs. For more information, see the [Django REST authentication docs](https://django-rest-auth.readthedocs.io/en/latest). 

## Create efficient programs
No matter what technology you use, it’s always a good practice to create efficient programs.

Django has a database-abstraction API to makes queries easily. As an example, let’s take another look at our Person model. First, we query the database for instances of people who are over 18 years old with this code:

``` python
over_18_people = Person.objects.filter(age__gte=18)
```

As its name suggests, the `filter` function filters the query according to our criteria. `__gte` means greater than or equal to.

Now imagine that we also have people’s pets in our database:

``` python
from django.db import models
from applications.people.models import Person

class Pet(models.Model):
    owner = models.ForeignKey(Person, related_name='pets', on_delete=models.CASCADE)
    name = models.CharField(max_length=30)
```

`ForeignKey` defines a relationship between `Person` and `Pet`. A pet can belong to one person, and one person can have many pets. We might want to print the name of each person and the information about each person’s pets for everyone in the system. This example shows an intuitive way to do that:

``` python
for person in Person.objects.all():
    print(person.name)
    print('pets info:')
    for pet in person.pets.all():
        print(pet.name)
    print('---')
```

This solution works well, but how many times do the queries have to run? The answer is N + 1 times: once to get all the people and N times to get each person’s pets, assuming N is the number of people in the database. If the value of N is very large, that makes a lot of queries. 
Let’s look at another solution to the same problem:

``` python
for person in Person.objects.all().prefetch_related('pets'):
    print(person.name)
    print('pets info:')
    for pet in person.pets:
        print(pet.name)
    print('---')
```

This code also solves the problem, but the number of times it accesses the database is 1. That’s a big difference.

> Tip: Minimize the number of queries.

Finally, let’s imagine your database is in another server, and a single query takes 1 ms to run. If there are 10,000 people in it, then the solution in the first example solution would take about 10 seconds to get things done. That’s much longer than the 1 ms it would take with second example.

To save time and resources, write code that minimizes the number of accesses to the database. The Django API has lots of functions that do the exact same thing in lots of different ways. Choose the ones that minimize the number of queries because it’s always faster to work in memory. Learn to write efficient code by exploring Django’s documentation about [attributes and functions](https://docs.djangoproject.com/en/2.2/topics/db/queries).

## The importance of testing
I won’t say that testing is a good practice because it’s way more than that. Testing is essential for every project. Every application needs testing, and I take that for granted.

> Tip: Use Factory boy and Faker.

In most of the cases, you’ll need to generate initial data for testing. So a programmer might run tests that have an “initial system” with previously loaded instances and relationships between them. This improves the quality, maintainability, and velocity of testing. 
You can load initial data with Django, using fixtures, migrations, and other functionalities. Now let’s look at a JSON fixture that takes the `Person` class:

``` json
[
  {
    "model": "applications.person",
    "pk": 1,
    "fields": {
      "name": "Rick Sanchez",
      "age": 70
    }
  },
  {
    "model": "applications.person",
    "pk": 2,
    "fields": {
      "name": "Summer Smith",
      "age": 17
    }
  }
]
```

By defining this fixture, we provide two instances at the beginning of the tests, and we generate new test cases with this as starting point. What if we want to test a bigger list of people? It would be cumbersome to enter info for each person manually, and the fixture file would need a huge number of lines. Fortunately, we don’t have to do that because the named tool [Factory boy](https://factoryboy.readthedocs.io/en/latest) gives us a better way.

### Factory boy
With Factory boy, you can generate test data with a just few lines, which improves maintainability. You can also define classes attached to the model classes. So at the same time that you run tests, you can easily create instances in memory or in the database and also replace any static hard-to-maintain fixtures. This example is related to the `Person` class:

``` python
import factory
from applications.people.models import Person

class PersonFactory(factory.DjangoModelFactory):
    name = factory.Sequence(lambda n: 'John Doe{0}'.format(n))
    age = 25

    class Meta:
        model = Person
```

To generate 100 instances of people for my tests with this definition, I run this command:

``` python
PersonFactory.create_batch(100)
```

As you can see, it’s very simple. Whit the `name` defined as `Sequence(lambda n: 'John Doe{0}'.format(n))`, the tool generates users with the names John Doe0, John Doe1, John Doe2, and so on. 
Faker
The Faker tool is a package that generates fake random and realistic data. When you integrate it with Factory boy, it generates more significant tests with more realistic initial data. To see this integration in action, let’s change the factory class:
``` python
import factory
from applications.people.models import Person

class PersonFactory(factory.Factory):
    name = factory.Faker('name')
    age = 25

    class Meta:
        model = Person
```
Now, if we execute the `create_batch(100)` function, we generate 100 people with realistic random names. Faker has a `pyint` function that generates random integers for `age`. To learn more about this package, read the [Faker docs](https://faker.readthedocs.io/en/master).

> Tip: Use tools to replace static fixtures.

Define good initial data for testing and keep it maintainable. For more ways to integrate these tools with Django, take a look at the common recipes in the Factory boy documentation.

## What to avoid
### Excessive use of signals
Django and Django REST have many tools and methods to attack several problems in a lot of ways. Signals are a good tool but they can cause problems if they’re used the wrong way.

Signals implement the observer design pattern, and it’s important to understand these concepts:

+ A **Signal** is an element that corresponds to an event. A signal can send notifications about the related event to it. In the observer pattern, the signal corresponds to the subject.
+ **Receivers** are the callables connected to a given signal. In the observer pattern, they correspond to the observer. After the associated event occurs and triggers the signal, each receiver is notified by that signal.

With the signals tool, you can send a notification after some predefined event. Some examples are when a new object in a model is created or destroyed, or a change is made in a relationship between models. To explore all the [functionalities of signals](https://docs.djangoproject.com/en/2.2/topics/signals), read the Django signal documentation.

> Tip: Be careful with signals.

Overuse of signals often generates mysterious side effects that degrade maintainability. These problems happen because signals are triggered after selected events. Programmers who forget that or simply don’t know it sometimes run unwanted code in the wrong places.

Whenever you change something about the events that trigger a signal, you might need to make changes in the corresponding signals. It’s easy to forget to check that because these signals are defined in other files.

To save time and effort, avoid the overuse of signals. For example, you might have two apps **A** and **B**, where **A** needs to trigger a function in **B**. If app **A** already knows app **B**, then don’t use signals. In this case, app **A** will import the needed functions from app **B** and make the calls directly.
 
### When signals are useful
A good use for signals is for breaking circular dependencies between Django apps. For example, you might have app **A** that depends on another app **B**, where **B** also needs things from **A**. A signal can break that circular dependency. Another example is if you have a model of third-party apps that you have no control over, and you want to trigger a process after some event of the model. Signals are also helpful in that scenario.

### url versus path
> Tip: Don't define urls with regular expressions unless is neccesary.

If you search internet for help to code in Django, you’ll probably find example code with the `url` function. And you might try to use it to solve your problem.

For an example of how the `url` function works, let’s define a URL with this general form:

`api/v1/people/<token>`

Where `<token>` can be a string with any character. Whit the named function would be:

``` python
url(r'^api/v1/people/(?P<token>[\w\-]+)/$', …)
```

It’s much easier to define the URL by using a Django dispatcher named path:

``` python
path('api/v1/people/<str:token>', …)
```

The difference between these methods is that the first one needs regular expressions. The second one has defined types that already cover the most common cases. At times, you might need to use regular expressions anyway. There’s a function for that named **re_path**. You can learn more about [URL dispatcher](https://docs.djangoproject.com/en/2.2/topics/http/urls) in the Django documentations.

## Learning Django
In this blog, I shared many of the lessons I learned by programming with the Django frameworks. I also recommended good practices for developing web apps, structures, functionalities, and general programming. This information can help you improve the quality and maintainability of your code. To make things easier for you, I described some of the problems I found with these tools and provided solutions for them.

I talked first about the importance of a good structure and configuration for several environments. Then main concepts of Django related to easy ways of implementing functionalities, taking advantage of tools already implemented to solve general problems. After that, I recommended some practices for efficiency, and then APIs and packages for session management and testing. Finally I talked about things that are better to avoid, because I already faced those problems before and I would like other people could skip them while learning these tools. I still have a lot to learn about Django and Django REST framework, but I hope what I’ve learned so far and shared with you has been useful and interesting.
