## Simple dynamic settings for Django


### Introduction

Not long ago I finished working on a small project in Django, and I noted that there were a few functionalities depending directly on constant values defined in the *settings* file but that given the nature of said functionalities it seemed like a good idea to be able to modify those values to alter the application behaviour without having to edit the settings and deploy the project again.

After doing some research on the topic I learned that there were a few libraries that provided an implementation to handle editable or dynamic setting, but I felt they were a little overkill for the purposes of this project. Given that, I decided to implement my own solution wich is simpler than the ones already implemented.


### Editing periodic celery tasks schedules

The project included a couple periodic tasks running with Celery whose schedules I wanted to be able to edit, in this case the solution was very straightforward thanks to [django-celery-beats](https://github.com/celery/django-celery-beat).

Django-celery-beats is a library for Django that provides us with models for periodic tasks and models that helps us define and modify with a great degree of freedom on when and how those tasks will be executed and it can be done through code or through the Django admin page, which results very helpful.

Assuming you already have Celery integrated to your Django project all you have to do is install django-celery-beats and modify your settings file re-assigning or defining the `CELERY_BEAT_SCHEDULER` to be `'django_celery_beat.schedulers:DatabaseScheduler'`. After that all you have to do is run the `manage.py migrate` command and you are done.


### Using a model to store configurations

The fundamental idea is to define a model and use its fields to store the values that will be used as settings to determine the behaviour of certain functionalities instead of using the *settings* file.
Given the fact that we want the settings to be consistent wherever we read them from in the code it would be convenient to have only one instance of this model, in other words an implementation of the Singleton design pattern.
Technically we won't be implementing a singleton, but for our purposes it will be the same.

First we will define an abstract model that will be the basis for our settings model and that will provide the basic behaviour:

```python
class Singleton(models.Model):

    class Meta:
        abstract = True

    def save(self, *args, **kwargs):
        self.pk = 1
        super(Singleton, self).save(*args, **kwargs)

    def delete(self, *args, **kwargs):
        pass

    @classmethod
    def load(cls):
        obj, _ = cls.objects.get_or_create(pk=1)
        return obj
```

- The `save` method assigns a value of 1 to the primary key field of any instance of `Singleton` before saving it, overwriting any previously saved register in the database's singleton table.
- The `load` method returns an instance of `Singleton` that represents the only existing register in the table (if there are no registers it creates one).
- Finally the `delete` method does nothing.

As previously said, this implementation does not correspond to the Singleton pattern because it is possible for multiple instances of the model to exist at the same time, but it guarantees that in any moment at most one register associated to `Singleton` can exist in the database, wich gives us the consistency that we wanted.

Now we can define our `EditableSettings` model wich inherits from `Singleton` and that simply contains the values that we will use as settings.

```python
class EditableSettings(Singleton):
    settings_value_1 = models.CharField()
    settings_value_2 = models.IntegerField()
    settings_value_3 = models.CharField()
```

Personally, I'd recommend to assign a default value to every field to have a default configuration set.
Now we can register this model in the admin page and modify it from the Django admin page.


### A couple things to take into account

1. Usually we will access the values from `EditableSettings` the following way:

```
editable_settings = EditableSettings.load()
value = editable_settings.settings_value_1
```

And that works as expected in most cases, but calling the `load` method can cause some issues if we have not yet run our migrations.
For example, let's say you call the `load` method inside the `admin.py` file of some app. Even though it could work fine in your development environment, when deploying the project it would raise a `ProgrammingError` because `load` will try to either read or write to a table that does not exist yet.

Two possible fixes are:

- You can create a new instance of the model directly instead of `load` in places where doing so could cause problems.
- You can use a `try - except` in the model code to catch the error and return an instance in the `except` code. This way you can just call `load` anywhere.

2. If some field of the model is accesed from code that is loaded only once then future changes to the value of that field won't be reflected unless you restart your project.
Further research is needed in order to find a fix to this issue.


### Summary

A simple implementation was proposed to be able to modify a project's configuration on runtime, while this implementation has clear limitations it is worth mentioning that when it is combined with django-celery-beats it provides an easy and effective solution to customize a django application's functionality.


### Annex

If the proposed solution does not fit the reader's needs here is a list of existing django librarys that could be useful.

- [Django-constance](https://github.com/jazzband/django-constance)
- [Django-djconfig](https://github.com/nitely/django-djconfig)
- [Django-dynamic-preferences](https://github.com/EliotBerriot/django-dynamic-preferences)

The code presented in this article is based on that presented on the following [blog post](https://steelkiwi.com/blog/practical-application-singleton-design-pattern/).
