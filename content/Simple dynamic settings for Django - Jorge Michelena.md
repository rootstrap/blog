## How to manage dynamic settings in Django

I recently finished working on a small project in Django when I realized that it could be improved greatly by adding a single feature.
There were a few functionalities depending directly on constant values defined in the *settings* file but given their nature, it seemed like a good idea to be able to modify them on runtime. This way the application's behavior could be altered without having to edit its settings file and deploy the project again.

After doing some research on the topic I learned that there are a few libraries that provide an implementation to handle editable or dynamic settings, but I felt they are a little overkill for the purposes of this project. Given that, I decided to implement my own solution which is simpler than the ones that are already implemented.


### Editing periodic celery tasks schedules

The project included a couple of periodic tasks running with Celery and I wanted to be able to edit those tasks' schedules, in this case, the solution was very straightforward thanks to [django-celery-beat](https://github.com/celery/django-celery-beat).

Django-celery-beat is a library for Django that provides us with models for periodic tasks and models that help us to define and modify when and how those tasks will be executed; having a great degree of freedom. It can be done through code or the Django admin page, which results to be very helpful.

Assuming you already have Celery integrated to your Django project all you have to do is install django-celery-beat and modify your settings file re-assigning or defining the `CELERY_BEAT_SCHEDULER` to be `'django_celery_beat.schedulers:DatabaseScheduler'`. After that, all you have to do is run the `manage.py migrate` command, and you are done.


### Using a model to store configurations

The fundamental idea is to define a model and use its fields to store the values that will be used as settings to determine the behavior of certain functionalities instead of using the *settings* file.
Given the fact that we want the settings to be consistent wherever we read them from in the code, it would be convenient to have only one instance of this model, in other words, an implementation of the Singleton design pattern.
Technically we won't be implementing a singleton, but for our purposes it will be the same.

First, we will define an abstract model that will be the basis for our settings model and that will provide the basic behavior:

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
- The `load` method returns an instance of `Singleton` that represents the only existing record in the table (if there are no records then creates one).
- Finally the `delete` method does nothing.

As previously stated, this implementation does not correspond to the Singleton pattern because it is possible for multiple instances of the model to exist at the same time, but it guarantees that in any moment at most one register associated to `Singleton` can exist in the database, which gives us the consistency that we wanted.

Now we can define our `EditableSettings` model which inherits from `Singleton` and that simply contains the values that we will use as settings.

```python
class EditableSettings(Singleton):
    settings_value_1 = models.CharField()
    settings_value_2 = models.IntegerField()
    settings_value_3 = models.CharField()
```

Personally, I recommend assigning a default value to every field in order to have a default configuration set.
Now we can register this model in the admin page and modify it from the Django admin page.


### A couple of things to keep in mind

1. In general, we will access the values from `EditableSettings` as follows:

```
editable_settings = EditableSettings.load()
value = editable_settings.settings_value_1
```

And that works as expected in most cases, but calling the `load` method can cause some problems if we haven't run our migrations yet.
For example, let's say you call the `load` method inside the `admin.py` file of some app. Even though it could work fine in your development environment, when deploying the project it would raise a `ProgrammingError` because `load` will try to either read or write to a table that does not exist yet.

Two possible fixes are:

- You can create a new instance of the model directly instead of loading in places where it could cause problems.
- You can use a `try - except` block in the model to catch the error and return a correct instance. This way you can call `load` anywhere.

2. If some field of the model is accessed from code that is loaded only once then future changes to the value of that field won't be reflected unless you restart your project.
Further research is needed in order to find a fix to this issue.


### Summary

A simple implementation was proposed to be able to modify a project's configuration on runtime. While this implementation has clear limitations it is worth mentioning that when it is combined with django-celery-beat it provides an easy and effective solution to customize a Django application's functionality.


### Annex

If the proposed solution does not fit the reader's needs here is a list of existing Django libraries that could be useful.

- [Django-constance](https://github.com/jazzband/django-constance)
- [Django-djconfig](https://github.com/nitely/django-djconfig)
- [Django-dynamic-preferences](https://github.com/EliotBerriot/django-dynamic-preferences)

The code presented in this article is based on the one in this following [blog post](https://steelkiwi.com/blog/practical-application-singleton-design-pattern/).
