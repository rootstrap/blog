# **ActiveAdmin 2FA with OneLogin**

![main image](images/2fa.jpg)

Here at [Rootstrap](https://www.rootstrap.com/mobile-app-development-los-angeles/), security is one of the top priorities, for us and for our clients. We ensure that malicious users can’t access any sensitive information from our client’s web apps.

In this blog post, you’ll learn how to configure two factor authentication with OneLogin for your admin panel.


##
**1) Some key concepts to security**

 - SLO (Single log out): SLO is a process that allows users to be logged out in one place and spread it over multiple applications

 - SSO (Single sign in): SSO is a process that allows users to authenticate into multiple services after logging into a primary service

 - Callback URL: It is a local URL in your app where a third party auth provider sends you auth data like confirmations or logout requests


##
**2) How to start implementing two factor authentication?**


First take a look at this lovely [gem](https://github.com/apokalipto/devise_saml_authenticatable), you will notice that all the examples are for the `User` class, but don't worry we will show some examples for admin specifically

The specific lines you need to add are just a few ones:

First add the devise `saml_authenticable` module from our choosen gem, this will inject most of the needed capabilities.

https://gist.github.com/fedeagripa/063d8ba4294aa19d95a18372ef6768f8

Then tell `saml_authenticable` module which SAML fields you want to map to your model ones

https://gist.github.com/fedeagripa/4f1567469b1310afced11af949fb511c

Almost done, add some configuration to your devise initializer to configure the communication between your third party provider and devise.
You can customize the named routes generated in case of named route collisions with other Devise modules or libraries. Set the saml_route_helper_prefix to a string that will be appended to the named route.
If saml_route_helper_prefix = 'saml' then the new_user_session route becomes new_saml_user_session

https://gist.github.com/fedeagripa/8ac3e511401d718661d60c8bb185682b

Finally, we need to modify devise to use our new login strategy. To achieve this we will modify session management so it redirects to our third party provider like this:

https://gist.github.com/fedeagripa/dbcc29097f3e4c2d0b75c36a16af3c6e

https://gist.github.com/fedeagripa/fdf179b625787ee4b9287d82ee59da51

###
**And that's all? wow!!!**

Well.... not really, sorry for getting you excited ¯\\_(ツ)_/¯

As you can see in the initializer there are some conditionals for development, that's because there is no dev out there that wants to do a 2FA every time they want to access ActiveAdmin locally.
So we still need to add some code to conditionally enable 2FA depending on the environment, and a flag (because we don't want to block access to admin if something happens to OneLogin also)

We need to check:
  - Usual admin login page works in development
  - Turning the feature off uses the old admin login and it works
  - How logout works


To perform the first two points I ended up adding the next lines to our overridden sessions_controller, seems that they are lost from super as you override it

https://gist.github.com/fedeagripa/69a868ad03da582a17a4593848a5aecf

**How logout works**

At this point you have 3 options to logout:
  - destroy your app session
  - destroy saml session
  - force logout from your third party auth partner

For this specific case, we needed to perform the first one only, because logging someone out of OneLogin means they will be logged out of a lot of apps, and that was not desired.
Actually it was a pain in the neck to do this, because `devise_saml_authenticable` gem adds routes using `class_eval` approach directly to `Devise` engine, leaving you with almost no way to configure which routes you really want or not. You will be asking yourself `Why would I like to remove a route?`, well... that's because at this point you have 2 `admin/logout` routes in your app, and we know this is not a good practice at all.
I ended up with this solution as the "cleanest":

https://gist.github.com/fedeagripa/00b1f67f762008677a71ea4913568c23

You can add last lines at the end of your devise initializer, or even better create a new initializer that run after devise one.


##
**3) Conclusions**

A project that was estimated to last over a month or so, ends up tacking only 2 weeks because we found a great gem that solves most of our problems (besides some gem implementations not being done in the best way).
Work does not end here, besides sharing this I'm planning to contributing back to this awesome gem to improve its quality and support missing points we mentioned. And my goal with this post besides showing how to solve a security problem is to encourage others to contribute back when you see you can do it, without contributions like this, this gem wouldn't exist and neither would this post.
