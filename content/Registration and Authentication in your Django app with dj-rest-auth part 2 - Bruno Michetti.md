## Registration and Authentication in your Django app with dj-rest-auth (part 2)

In the [first part of this blog post](link-to-part-1) I've presented the dj-rest-auth package that allows us to handle registration and authentication through REST API endpoints with a minimal configuration.
I've also talked about different customizations that you can take advantage of.
When I started to use this package I had to face some problems. The roots of those problems were partly because I was learning Django and partly because dj-rest-auth has many features and possibilities for each feature that the first time is used it can lead to some confusion. So the main goal of the second part is to show you more examples and give you some tips. Let's continue with the example of the `CustomUser` shown in the previous part, with unique email, a gender and a phone number attribute.

### Sign-up with email verification

Having installed and integrated dj-rest-auth to your Django app, it's possible to configure email verification at the moment that a user registers. This means that a successfully registered user has to check the inbox and confirm trough the received email that he really is the owner of the email account. To do this, go to your settings and turn on email verification:

```python
# Your settings file
...

ACCOUNT_EMAIL_VERIFICATION = 'mandatory'
```

With this, after a correct sign-up your app will send a verification email to the entered account. But you didn't finish: as dj-rest-auth [documentation](https://dj-rest-auth.readthedocs.io/en/latest/api_endpoints.html#registration) says, after enabling the email verification, you need to add a path to your urls to be used by the verification view:

```python
# Your urls file
...
from dj_rest_auth.registration.views import VerifyEmailView

...

urlpatterns = [
    ...
    path(
        'dj-rest-auth/account-confirm-email/',
        VerifyEmailView.as_view(),
        name='account_email_verification_sent'
    ),
    ...
]

```

If you don't do that, you will get a [NoReverseMatch](https://docs.djangoproject.com/en/3.1/ref/exceptions/#noreversematch) error.  
Also, let's use an allauth configuration to activate the email account after the user clicks on the link received in the email. Add this to your settings:

```python
# Your settings file
...
ACCOUNT_CONFIRM_EMAIL_ON_GET = True
```

And add this path to your urls file `before` the definition of the `dj-rest-auth` registration path:

```python
# Your urls file
...
from dj_rest_auth.registration.views import VerifyEmailView, ConfirmEmailView

...

urlpatterns = [
    ...
    path(
        'dj-rest-auth/registration/account-confirm-email/<str:key>/',
        ConfirmEmailView.as_view(),
    ), # Needs to be defined before the registration path
    path('dj-rest-auth/registration/', include('dj_rest_auth.registration.urls')),
    path('dj-rest-auth/account-confirm-email/', VerifyEmailView.as_view(), name='account_email_verification_sent'),
    ...
]

```

Having this configuration, the user will be redirected to the login page after clicking in the received link. Don't forget to set the `LOGIN_URL` parameter in your settings, otherwise you can get an error. During development, you can set the `LOGIN_URL` as the login endpoint; remember that dj-rest-auth has browsable endpoints. So you can test sign-up flow by setting for example:

```python
# Your settings file
...
LOGIN_URL = 'http://localhost:8000/dj-rest-auth/login'
```

Now we need to specify to Django the email backend that is in charge of sending the emails. To locally test the signup feature during development, you can set:

```python
# Your settings file
...
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

```

In this case the email won't be sent, it will be printed in the console instead. By default, you will see something like this after a successful registration:

<img src="images/dj-rest-auth-console-email-example.png" alt="Email console example" />

If you open your browser and go to the link shown in the printed email, the user's account will be activated and you will be redirected to the browsable login endpoint. Now you are able to login with the entered email and password.  
And there it is! You have configured signup with email verification. Now let's see some other email backend settings to actually send the email.

#### Email backend

It's possible to configure the [Django email backend](https://docs.djangoproject.com/en/3.1/topics/email/#email-backends) in different ways. You can configure an SMTP server by adding:

```python
# Your settings file
...

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'your.email.host'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = 'your email host user'
EMAIL_HOST_PASSWORD = 'your email host password'
```

You have to choose the `EMAIL_HOST`, for example `'smpt.gmail.com'`. In the `EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD` parameters put the information of the account that will be the email sender. If you are using gmail as mail server
you will need to allow less secure apps and display unlock captcha. After this, your Django app will send verification emails for all the new users.  
There are also more possibilities for email backend thay you can try, such as [SendGrid](https://sendgrid.com/docs/for-developers/sending-email/django/). To finish this section, I recommend you to use environment variables to keep sensitive information in your settings such as keys, the email host user and its password, etc.

### Email templates

### Customized reset password

### Social network integrations

### Summary
