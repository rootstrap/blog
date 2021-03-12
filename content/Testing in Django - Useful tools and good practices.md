# Testing in Django and Django REST - Useful tools and good practices

If you are a developer, you already know how important is to test in any software project. More specifically, automatic testing helps you to corroborate your coding and
see in a fast way that your program does what you want it to do. Also helps you to corroborate that the new changes in your code, didn't break the previous functionalities.

Does this mean that if you have automatic tests then your project won't have any errors? Noup.
[Edsger W. Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra) the computer scientist says:  

`“Program testing can be used to show the presence of bugs, but never to show their absence”`.  

This phrase make us to understand that we can't be sure that our program is perfect, but anyway testing is fundamental to discover errors and make fixes and improvements.
As a person that works in software development, I can say that it's a lot better that you discover the error, than your client, or a user in production. In this blog I'll talk about automatic testing, useful tools and good practices in [Django](https://www.djangoproject.com/) projects, more focused on API's.

## Testing in Django and Django REST Framework
Django has a very nice [documentation](https://docs.djangoproject.com/en/3.1/topics/testing/) about testing, and [Django REST Framework](https://www.django-rest-framework.org/api-guide/testing/) too. So in this blog I'll talk just a little bit of the main tools in those two frameworks, and what you can do and use to improve your testing.

### Main testing classes
Django provides several classes for testing. The one I'll talk about here is [TestCase](https://docs.djangoproject.com/en/3.1/topics/testing/tools/#django.test.TestCase), very useful if your application uses databases.  
As the name says, to create a test case in your Django project, you will define a class that inherits from TestCase. Doing this, you can use all the methods and properties of the named class that will help you to create and execute your tests. Then you will define different functions that will correspond to each unit test inside the test case. Let's see an example of the structure of a test case:

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

Also, you can use the [Client](https://docs.djangoproject.com/en/3.1/topics/testing/tools/#django.test.Client) class of Django, that simulates a dummy browser, so you can make HTTP requests and test how your Django API responds.  

Since this blog is focused in API testing, I want to talk about [APITestCase](https://www.django-rest-framework.org/api-guide/testing/#api-test-cases), a class of Django REST framework, that is a mirror of TestCase, but it uses a different client class: [APIClient](https://www.django-rest-framework.org/api-guide/testing/#apiclient). This client extends the TestClient. That means that has the same functionalities, and adds some other, such as the `credentials` function. This function is very useful to overwrite authentication headers, for example using OAuth1, OAuth2, or any simple token authentication scheme.  
So if you are working on a project with Django REST framework, you can change the previous example in this way:


```python
# your test file
from rest_framework.test import APITestCase


# class to define a test case of login
class UserLoginTestCase(APITestCase):

    ...
```

### Main testing functions
The mentioned classes have a set of methods that will help you through the testing. With these functions you are able to corroborate that your software works as expected, and make test fixtures.  
A test fixture is an environment that you can create to run your tests having consistency. Using a fixture you can make sure that certain conditions are met before the execution. For example, to have at the beginning a determined set of data in your testing database, or to create needed objects, etc. Here is a list of the main ones:
- `setUp` and `tearDown`: These are functions to be executed before (setUp) and after (tearDown) each unit test. Very useful to for fixtures.
- `setUpClass` and `tearDownClass`: In an analogous way of setUp and tearDown, this functions are executed before (setUpClass) and after (tearDownClass) the whole test case. This means that are executed only once for a test case. Since are used by Django to make important configurations, if you overwrite these methods in your test case class, don't forget to call the `super` implementation inside the functions.
- `setUpTestData`: this function can be used to have a class-level atomic block to define data for the whole test case. That means that this function automatically rollbacks the changes in the database after the finalization of all the unit tests in the test case. Mainly used to load data to your test database.
- Assert methods: Django has the set of [assert methods from unittest](https://docs.python.org/3/library/unittest.html#assert-methods), and has [another ones created for the framework](https://docs.djangoproject.com/en/3.2/topics/testing/tools/#assertions). These methods, such as `assertEqual`, `assertIsNone`, `assertTrue`, etc, can be used in the unit test, to check the different conditions that have to be met. For example, in the unit test of login, you can assert that the response has a status code of 200 because you want to make sure that if the data is sent correctly, then your application has to return the response with that code.  

You can avoid using these functions, or use any combination of them. They're no needed, but they're very useful and will help you a lot.

### Test discovery and databases
Where do you have to put your tests classes? By default, Django recognizes any file that fullfil the pattern `test*.py` under the current working directory. That is, any file under the directory that starts with `test` and of course has the `.py` extension. Inside it, Django will execute any function in the test case class starting with `test`.  
When you run your tests, you can pass a parameter indicating the desired pattern, just in case you want to use a different one. With that behavior, the place to put the test cases can be anywhere, but I recommend to divide the tests into the several Django apps that you may have in your project. For example, if you have a Django app called `users` that has the models and functionalities related to the users in your project, you can define in there a `test` folder as a module with all the tests that cover that important part: tests for login, for sign-up, for user data, account deletion, etc. Something similar to this:

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

Regarding the databases, when you run your tests by default Django creates one and destroys it after the finalization. This is to avoid conflicts between your production and/or development databases, and your testing database.
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
        },
}
```

If you don't define that `TEST` dictionary, Django will create a database naming it equal as your database in the `default` settings, appending the `test_` prefix.

## Useful tools and good practices

### Factory Boy

### Faker

### Test case example

## Running your test

### Commands

## Summary
