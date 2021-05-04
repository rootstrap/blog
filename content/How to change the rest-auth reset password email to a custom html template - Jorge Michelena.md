We have talked in previous blog posts about Django rest framework and about rest-auth, both amazing libraries for Django that allow us to easily create rest apis and handle user authentication respectively, in this blog we will focus particularly in rest-auth and in one of its built in functionalities which is the reset password feature.

If a user wants to reset their password because they forgot it or because they want to start using a different password then usually they must first make a reset password request and then they'll receive an email with a link to a page in which they will be able to introduce and set their new password.

This feature is provided by the rest-auth library but the email that is sent to the user is a plain text one and the link that comes in the email is that of a built-in rest-auth endpoint, which may be exactly what you want in some cases, but not in others.
If you want to change the content of the email the process is well documented but only if you want to change it to a plain text file, in case you want to change to a custom html template then there is not much information covering how to do it, that is why we will explain it in this article.

### Set up

I'm going to asume that you have python, django, django rest framework and rest-auth installed as well as a project ready on which you are going to make these changes.
In my case I made a very simple project called `project` with just one app called `api`, and the following layout:


```
├── api
│   ├── __init__.py
│   ├── apps.py
│   ├── migrations
│   │   ├── __init__.py
│   └── serializers.py
├── db.sqlite3
├── manage.py
├── project
│   ├── __init__.py
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   ├── widgets.py
│   └── wsgi.py
└── templates
    └── registration
        └── custom_reset_confirm.html
```

As you can see I have a `templates` folder in which I made a new folder called `registration` with a file called `custom_reset_confirm.html` inside of it.
The context in the html email template looks like this:

```html
<html>
  <head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Confirm reset password email</title>
  </head>
  <body style="text-align: center;">
    
    <h2>Hello!</h2>
    <br>
    <p><b>You're receiving this email because you requested a password reset for your user account at {{ site_name }}.</b></p>
    <br>
    <p> Please go to the following page and choose a new password: </p>
    <p> {{ protocol }}://{{ domain }}{% url 'password_reset_confirm' uidb64=uid token=token %} </p>
    <p> Your username, in case you’ve forgotten: {{ user.get_username }} </p>
    <br>
    <p><i> Thanks for using our site! The {{ site_name }} team.</i></p>
  </body>

</html>


```

As you may have noticed, the content is pretty much the same as in the default email, and for the sake of simplicity I didn't add a lot of style, just some bold and italic text as well as greeting in a bigger font size.
The relevant variables like `site_name`, `domain` and such will be automatically assigned values passed on the context to the template.

### Changing the default email

Now that we have our template what we need to do is indicate that this is what we want to send our users when they request to reset
their password, to do that we have to define a serializer that inherits from `rest-auth`'s `PasswordResetSerializer` and overwrite
its `get_email_options` method and then use that serializer instead of the default one.

So first we will define the new serializer:

```python
 from dj_rest_auth.serializers import PasswordResetSerializer


class CustomPasswordResetSerializer(PasswordResetSerializer):
    def get_email_options(self):
        return {
            'html_email_template_name': 'registration/custom_reset_confirm.html',
        }

```

And then in our `settings.py` we will indicate that this is the serializer we want to use:


```python

...

REST_AUTH_SERIALIZERS = {
    'PASSWORD_RESET_SERIALIZER': 'api.serializers.CustomPasswordResetSerializer',
}

...

```

Now if you send a reset password request you should receive something like this:


![image](images/old_screenshot.png)


In my case because I'm running this project locally it uses `localhost:8000` for the `site_name`.

Now, let's say that you want to add something else to this email, some information that is bound to change and so
you wouldn't want to hardcode on the template itself, for example let's say I want to add a link to social media, in that case
I can add the key `extra_email_context` to the dictionary that `get_email_options` returns and as its value a dictionary with the extra
context.

For example, let's replace `The {{ site_name }} team` at the end with a fake url:

```html
...

    <br>
    <p><i> Thanks for using our site! Follow us on: {{ social_media_url }}.</i></p>
  </body>

...
```

And now define the value of `social_media_url` in the serializer.

```python
class CustomPasswordResetSerializer(PasswordResetSerializer):
    def get_email_options(self):
        return {
            'html_email_template_name': 'registration/custom_reset_confirm.html',
            'extra_email_context': {
                'social_media_url': 'https://link-to-social-media.com',
            },
        }

```

![image](images/new_screenshot.png)

It is also possible to overwrite default values like `site_name` in the same way by using `extra_email_context`, but it is not recommended to do so.

And that's all!



### Conclusion

In this blog post you learned how to change the default rest-auth reset password email with a new html one by defining a custom `PasswordResetSerializer`,
as well as how to change/add information to the content of the email dinamically using the `get_email_options` method of the `PasswordResetSerializer` base class.
