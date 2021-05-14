# Testing in Django & Django REST - Basics, Useful Tools, & Good Practices

If you are a developer, you already know how important testing is in any software project. In particular, automatic testing, as it can help you to corroborate your coding, and quickly see what your program does what you want it to do. It also helps to corroborate any new changes in your code that didn't break any previous functionalities.

In saying that, does this mean that if you have automatic tests then your project won't have any errors? It does not.
As computer scientist Edsger W. Dijkstra once said:  

`“Program testing can be used to show the presence of bugs, but never to show their absence”`.  

This phrase helps us to understand that we can't be sure that a program is perfect, but, testing is fundamental to help us discover errors and make fixes and improvements.
As a person that works in software development, I can say that it's a lot better when **you** discover an error rather than your client or a user in production. In this article, I'll talk about basic knowledge in automatic testing, useful tools, and good practices in [Django](https://www.djangoproject.com/) projects, with a focus on API's.

## Testing in Django & Django REST Framework
Django has a very nice [documentation](https://docs.djangoproject.com/en/3.1/topics/testing/) about testing, and [Django REST Framework](https://www.django-rest-framework.org/api-guide/testing/) too. So, in this blog, I'll talk about the main tools in those two frameworks, and what you can do and use to improve your testing.

### Main Testing Classes
Django provides several classes for testing. The one I'll talk about here is [TestCase](https://docs.djangoproject.com/en/3.1/topics/testing/tools/#django.test.TestCase), which is very useful if your application uses databases.  
As the name states, to create a test case in your Django project, you will define a class that inherits from TestCase. By doing this, you can use all the methods and properties of the named class that will help you to create and execute your tests. Then you will define different functions that will correspond to each unit test inside the test case. Let's see an example of the structure of a test case:

```python
# your test file
from django.test import TestCase


# class to define a test case for login
class UserLoginTestCase(TestCase):

    ...
    # some setup here, explained later

    def test_correct_login(self):
        # unit test
        # Corroborate the expected scenario
        ...
    
    def test_if_password_incorrect_then_cant_login(self):
        # unit test
        # Corroborate that user's password needs to be only the correct one
        ...
    
    def test_if_user_not_registered_cant_login(self):
        # unit test
        # Corroborate that user's are able to login only if they're registered
    
    ...
```

Also, you can use the [Client](https://docs.djangoproject.com/en/3.1/topics/testing/tools/#django.test.Client) class of Django which simulates a dummy browser so you can make HTTP requests and test how your Django API responds.  

Since we are focusing on API testing, I want to talk about [APITestCase](https://www.django-rest-framework.org/api-guide/testing/#api-test-cases), a class of Django REST framework that is a mirror of TestCase but uses a different client class: [APIClient](https://www.django-rest-framework.org/api-guide/testing/#apiclient). This client extends the TestClient, meaning that it has the same functionalities and adds others such as the `credentials` function. This function is very useful to overwrite authentication headers, for example, using OAuth1, OAuth2, or any simple token authentication scheme.  
So, if you are working on a project with the Django REST framework, you can change the previous example in this way:


```python
# your test file
from rest_framework.test import APITestCase


# class to define a test case of login
class UserLoginTestCase(APITestCase):

    ...
```

### Main Testing Functions
The aforementioned classes each have a set of methods that will help you through the testing. With these functions, you are able to corroborate that your software works as expected and make necessary test fixtures.  
A test fixture is an environment that you can create to run your tests using consistency. Using fixtures you can make sure that certain conditions are met before the execution. For example, to have a determined set of data in your testing database, or to create needed objects. Here is a list of the main ones:
- `setUp` and `tearDown`: These are functions to be executed before (setUp) and after (tearDown) in each unit test. These are very useful for fixtures.
- `setUpClass` and `tearDownClass`: In an analogous way of setUp and tearDown, these functions are executed before (setUpClass) and after (tearDownClass) during the whole test case. This means that it is executed only once for a test case. Since they're used by Django to make important configurations, if you overwrite these methods in your test case class, don't forget to call the `super` implementation inside the functions.
- `setUpTestData`: this function can be used to have a class-level atomic block to define data for the whole test case. That means that this function automatically rollbacks the changes in the database after the finalization of all the unit tests in the test case. This is mainly used to load data to your test database.
- Assert methods: Django has the set of [assert methods from unittest](https://docs.python.org/3/library/unittest.html#assert-methods), and has [another one created for the framework](https://docs.djangoproject.com/en/3.2/topics/testing/tools/#assertions). These methods, such as `assertEqual`, `assertIsNone`, `assertTrue`, etc, can be used in the unit test to check the different conditions that have to be met. For example, in the unit test of login, you can assert that the response has a status code of 200 because you want to make sure that if the data is sent correctly, then your application has to return the response with that code.  

You can avoid using these functions, or use any combination of them. They're no needed, but they're very useful and will help you a lot.

### Test Discovery & Databases
Where do you have to put your test classes? By default, Django recognizes any file that fulfills the pattern `test*.py` under the current working directory. That is, any file under the directory that starts with `test`, and of course has the `.py` extension. Inside it, Django will execute any function in the test case class starting with `test`.  
When you run your tests, you can pass a parameter indicating the desired pattern just in case you want to use a different one. With that behavior, the place to put the test cases can be anywhere, but I recommend dividing the tests into the several Django apps that you may have in your project. For example, if you have a Django app called `users` that has the models and functionalities related to the users in your project, you can define in there a `test` folder as a module (adding the __init__.py file) with all the tests that cover that important part: tests for login, for sign-up, for user data, account deletion, etc. Something similar to this:

```
my_project
   |__django_apps
       |__users
          |__test
             |__ __init__.py
             |__ test_login.py
             |__ test_signup.py
             |__ test_delete_user.py
             ...
        ...
    ...
...
```

Regarding the databases, when you run your tests by default, Django creates one and then destroys it after the finalization. This is to avoid conflicts between your production and/or development databases, as well as your testing database.
You can define and customize a database for tests, inside the `DATABASES` dictionary, adding another one named `TEST`. Something like:

```python
DATABASES = {
    'default': {
        'ENGINE': '<engine>',
        'NAME': '<database name>',
        'USER': '<database user>',
        ...
    },
    ...
    'TEST': {
        # testing database customization here
            'NAME': '<your testing database name>',
            # some other customization, for example the user user, password, etc
        },
}
```

Take a look at the [available keys](https://docs.djangoproject.com/en/3.1/ref/settings/#test) for the `TEST` dictionary. If you don't define it, Django will create a database naming it equal to your database in the `default` settings, appending the `_test` suffix.

## Useful Tools
In this section, I will talk about two external tools that are very helpful for fixtures: [Faker](https://faker.readthedocs.io/en/master/) and [Factory Boy](https://factoryboy.readthedocs.io/en/stable/).

### Faker
Faker is a python package used to generate fake but realistic data. You can use its functionalities to load data into your testing database, generate data for the requests that you want to test, and generate data for the models, etc. Faker has a huge and diverse set of possibilities. You can generate in execution time, for example, first names, last names, phone numbers, dates, passwords, emails, etc. 

Additionally, you can pass parameters to the functions to generate data with different constraints, for example, you can obtain a password specifying if you want to use special characters or not, the desired length, and if you want to have an upper case or not, etc. Take a look at the [Faker providers](https://faker.readthedocs.io/en/master/providers.html) to see all the different fake but realistic data that you can generate for your tests. Instead of using for example `user_test@mail.com` for your test cases, you can have data that is closer to reality and improving the quality.

### Factory Boy
If you use factories for tests, you define in a class the data structure that you want to have in your testing database. Then in your tests it will be easier to have instances of your models, and loaded data with the desired structure. Factory Boy is a tool to replace static, hard to maintain fixtures using factories. Also you can combine it with Faker to have factories with fake but realistic data. Let's see an example:

In this case we can see a static fixture of Django, to load data to the testing database in a model called Person, that has a first name and last name. This JSON file defines two instances:

```json
[
  {
    "model": "myapp.person",
    "pk": 1,
    "fields": {
      "first_name": "John",
      "last_name": "Lennon"
    }
  },
  {
    "model": "myapp.person",
    "pk": 2,
    "fields": {
      "first_name": "Paul",
      "last_name": "McCartney"
    }
  }
]
```

Now let's see the analogous definition using Factory Boy and Faker:

```python
from factory import django, Faker
from myapp import models 

class PersonFactory(factory.django.DjangoModelFactory):

    class Meta:
        model = models.Person
    
    first_name = Faker('first_name')
    last_name = Faker('last_name')
```

With this, you can use functions that Factory Boy provides, for example, `PersonFactory.create_batch(2)` to create instantly 2 instances in your testing database of Person with different and realistic first and last names. In the JSON case, if you want to have for example 10 instances, you will need to add them and define new first and last names explicitly. And if you want to have huge datasets, the JSON file will be enormous and hard to maintain, while in the factory case you only need to call a function. Also, what if the model Person changes? In the JSON case, you have to update one by one each defined instance. In the factory case, you only need to change a class definition.
Factory Boy documentation has a section called [common recipes](https://factoryboy.readthedocs.io/en/stable/recipes.html), where you can find useful tools, practices, and tips from the library. Here is a list of interesting functionalities:

- You can create factories of models including the model relationships using the `RelatedFactory` or `SubFactory` class.
- Use the `create` function to create a new instance of the model in the factory and save it into the testing database. If you want to have instances but without saving them into the database, use `build` instead.
- In an analogous way, you can create and save into the database N instances of the model in the factory using `create_batch(N)`, and `build_batch(N)` if you don't want to save them.
- You can define an attribute in a factory that selects a choice of a set of choices just like a Django model choice field, using `random_element` of Faker. In the next section, we will see an example of this.


## Test Example & Good Practices
In this section I want to wrap up and show a little example. This is the tiny reality: In the project we have a Django app called users where we have the user model that have a username, phone_number, and a category in the system, that could be admin, common user, and guest. The user can sign-up and login in the application. 

### Model and factory definition

```python
# model.py in the Django app called users
from django.db import models
from django.contrib.auth.models import AbstractUser


# class to define choices
class Category(models.TextChoices):
    GUEST = 'G', 'Guest user'
    COMMON_USER = 'C', 'Common user'
    ADMIN = 'A', 'Admin user'


# user model that inherits from AbstractUser
# there is no need to define a username field
# because is defined in the parent class
class User(AbstractUser):
    phone_number = models.CharField(max_length=50, blank=True, null=True)
    category = models.CharField(
        max_length=1,
        choices=Category.choices,
        default='G',
    )
```

Now let's see the implementation of the user factory. This file is inside a test folder in the users Django app:

```python
# factory.py inside users/test
from faker import Faker as FakerClass
from typing import Any, Sequence
from factory import django, Faker, post_generation

from users.models import User, Category


CATEGORIES_VALUES = [x[0] for x in Category.choices]


class UserFactory(django.DjangoModelFactory):

    class Meta:
        model = User
    
    username = Faker('user_name')
    phone_number = Faker('phone_number')
    category = Faker('random_element', elements=CATEGORIES_VALUES)

    @post_generation
    def password(self, create: bool, extracted: Sequence[Any], **kwargs):
        password = (
            extracted
            if extracted
            else FakerClass().password(
                length=30,
                special_chars=True,
                digits=True,
                upper_case=True,
                lower_case=True,
            )
        )
        self.set_password(password)

```

A couple of things about this:
- In the `Meta` class inside the factory, we have to indicate the corresponding model.
- In the category attribute, we use `random_element` of Faker to randomly select a choice of the Category choice list. We've defined `CATEGORIES_VALUES` to specify which part of the choice we want to take. That is because each element in the choices list is a tuple, where the first part is the value, and the second one the explanatory text. So that `CATEGORIES_VALUES` set has only that first part for each element.
- Through the `post_generator` decorator and the `password` function, we indicate that at the moment of the creation of a user instance, we can pass a desired password to be used, or else we generate one using the Faker functionality.

### Test case
Now let's see an example of testing for the user sign-up functionality. The implementation of the authentication part for this example project, has been made using dj-rest-auth. I won't talk about that, but if you want to know more, please take a look at this [blog](https://www.rootstrap.com/blog/registration-and-authentication-in-django-apps-with-dj-rest-auth/). This is a test_singup.py file inside the test folder of the users Django app:

```python
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase, APIClient

from users.test.factory import UserFactory
from users.models import User, Category
from faker import Faker


class UserSignUpTestCase(APITestCase):

    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.user_object = UserFactory.build()
        cls.user_saved = UserFactory.create()
        cls.client = APIClient()
        cls.signup_url = reverse('rest_register')
        cls.faker_obj = Faker()

    def test_if_data_is_correct_then_signup(self):
        # Prepare data
        signup_dict = {
            'username': self.user_object.username,
            'password1': 'test_Pass',
            'password2': 'test_Pass',
            'phone_number': self.user_object.phone_number,
            'category': self.user_object.category,
        }
        # Make request
        response = self.client.post(self.signup_url, signup_dict)
        # Check status response
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 2)
        # Check database
        new_user = User.objects.get(username=self.user_object.username)
        self.assertEqual(
            new_user.category,
            self.user_object.category,
        )
        self.assertEqual(
            new_user.phone_number,
            self.user_object.phone_number,
        )

    def test_if_username_already_exists_dont_signup(self):
        # Prepare data with already saved user
        signup_dict = {
            'username': self.user_saved.username,
            'password1': 'test_Pass',
            'password2': 'test_Pass',
            'phone_number': self.user_saved.phone_number,
            'category': self.user_saved.category,
        }
        # Make request
        response = self.client.post(self.signup_url, signup_dict)
        # Check status response
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(
            str(response.data['username'][0]),
            'A user with that username already exists.',
        )
        # Check database
        # Check that there is only one user with the saved username
        username_query = User.objects.filter(username=self.user_saved.username)
        self.assertEqual(username_query.count(), 1)
```

Well, in this file we have a test case, defined as UserSignUpTestCase, and two unit tests inside, one to test the expected case, and the other to test an error case. I want to list a couple of main points to discuss good practices:
- Take a look at the unit tests names: You can name them as you want (always starting with `test` unless you change the pattern). A good practice is to make a name that describes it. This will help you when testing and debugging, for example if a test fails and you want to trace the error.
- In the setUpClass method, we call the `super()` function, remembering that it's important for Django. Also we set up the needed instances, such as the API client, a user and a faker instance. Besides we load a user to the database with the `create` function.
- Notice that the `sign_up` url defined in the setUpClass method, uses `reverse` from Django. You can put directly the url string if you want. But using reverse, you obtain an url entering the related name. In the dj-rest-auth package, the related name is `rest_register`. I recommend you to use reverse in your project to improve maintainability. When you define urls, give them a name, and then in the tests use reverse. After that, if a url changes, you won't need to change anything in the tests, because reverse solves this.
- The general structure chosen for the unit test is:
  - Prepare data: You can use the instance generated with `build` to obtain the data for the request.
  - Make the request: Use the APIClient to make the request.
  - Check the response: Check the response data (if there is data) and status. When working with Django REST framework, I recommend to use [status](https://www.django-rest-framework.org/api-guide/status-codes/). With this, you have the HTTP status codes in a cleaner way. If you don't want to, you can just put the number directly.
  - Check the database: If the request generates changes in the database, please corroborate it to make sure that the functionality modifies it correctly. If you have the case that doesn't modify the database, it's a good practice to test that the database remains without changes (just as in the second unit test).

This was an example of a Test Case with two unit tests. You can add more unit tests, for example to test that if some data is incorrect in the request, the user can't sign-up. Besides you can add in that file (or another file) more test case classes, for example to test the login functionality of the app.   

## Running your tests
Once you have coded a couple of tests, you can execute them with this command in the main folder of the project (the one that has the manage.py file):
- `python manage.py test`
This will search for all of your tests files under that folder and then execute them, showing the error or success of each unit test. 

### Customize the execution of the tests
You can customize the test execution, for example you can indicate to test:  
- Only a Django app, specifying `<Django app name>`: 
  - `python manage.py test users`
- Only a file in a given Django app, specifying `<Django app name>.path.to.file`:
  - `python manage.py test users.test.test_signup`
- Only a test case class, specifying: `<Django app name>.path.to.file.ClassName`:
  - `python manage.py test users.test.test_signup.UserSignUpTestCase`
- Only a unit test function, specifying `<Django app name>.path.to.file.ClassName.function_name`:
  - `python manage.py test users.test.test_signup.UserSignUpTestCase.test_if_data_is_correct_then_signup`

You can also add some flags to the command to customize the execution, for example:
- `--keepdb` to avoid erasing the database between executions. This can improve the speed.
- `--parallel` to run the tests in parallel improving also the speed on multi-core hardware. If you do this make sure they're well isolated.

## Summary
In this blog I've presented some basics of testing with Django and Django REST framework. Also I showed a couple of useful tools and good practices more focused on API's. I showed you some examples, and how to run and customize your tests with the named framework. I hope you have enjoyed the reading. I hope also that this blog can help you to test and improve your own Django API project. 
