# Django vs Flask: Which should You Choose For Your Project?
[Django](https://www.djangoproject.com/) and [Flask](https://flask.palletsprojects.com/en/1.1.x/) are two of the most popular Python web frameworks.
In this article, we're going to review their main strengths and weaknesses to help you decide which one is a better fit for your project.


# Django
[![django-logo](images/flask-vs-django-django-logo.png)](https://www.djangoproject.com/)
## Approach
Django opts for an all batteries-included approach.
From a powerful ORM to an authentication system or templating engine, Django takes care of it all without the need to learn any extra libraries.

It also has the concept of pluggable apps, which means you can drop an app folder inside your project and get its functionality right away with very little configuration. 

## Main Features
- Django has a very powerful ORM that exposes a lot of SQL to the python programming language.
- It has Authentication and Authorization built-in, without the need for any extra configuration.
- It also boasts a built-in admin site, and
 a built-in mailing system.

## Pitfalls
- Being tightly coupled with its toolset, Django can be difficult to use in combination with other tools, like replacing the form library, for example.
- While Django's **default scaffolding function** is not bad for small projects, it does not scale without modification when trying to manage things such as multiple environments.
- This functionality implements the Model View Template pattern but requires some effort to implement other architecture types with it.

## Developer Experience
One of the main perks of using an all batteries included approach, is that the developer experience will be more or less the same across the framework.
This can be very beneficial for users new to the framework as they can follow a pattern, and guide, for best practices by looking at existing code.
Another benefit you get from this approach is that the core parts of every site are tried and tested.
This is a very desirable feature for parts like authentication and authorization, or an admin panel used to provide easy back office access to your team.

## Team Size and Structure
Django is best served for small to medium-sized teams, that must handle middle to large-sized code bases.
The project structure takes that into account and as a result file conflicts will be minimal.
As it has a scaffolded default structure for its projects, it's easy to ramp up newbie developers to use it while under the supervision of a senior developer. 



# Flask
[![flask logo](images/django-vs-flask-flask-logo.png)](https://flask.palletsprojects.com/en/1.1.x/)
## Approach
Originally developed as a combination of an HTTP server and a template engine zipped together, Flask opts for a very minimalistic approach.
It provides some minimal structure, but leaves the decisions up to you.
This makes Flask very easy to extend with practically anything you want.

## Main Features
- Very lightweight.
-  Requires little to no configuration.
- Not opinionated, you have total freedom to decide the project structure from a single file to an elaborate folder system.
- When you need some structure, you have blueprints to structure your app.
- Easy to integrate with other python libraries.

## Pitfalls
- Since it's very lightweight, while the framework itself doesn't need any special configuration, the used libraries often do require config.
- You have to mix and match libraries to get the desired functionality. This also means that different parts of your project have different support from the community.
- The lack of opinions can lead to complicated architectures or very big single file projects.

## Developer Experience
Flask is what you want it to be.
But, it makes you work for it, and you can start importing any libraries you like and code your app in your own way.
This can be really cool, and makes a lot of sense if you want to quickly spin up a quick api for puting your python code on the web.
On the other hand, the lack of guidance can be a bit overwhelming for new users, and can also leave them a bit lost if they don't know how the framework operates. 
Also, if you want some standard features - like Authorization and Authentication, or an admin panel, you will have to search for third-party libraries or roll your own implementations.
This can be a bit repetitive since most applications have these kinds of features implemented to a certain degree.

# Team Size and Structure
The liberties that Flask gives you requires a lot of experience to take advantage of them.
The initial simplicity of a single file app can easily lead to a very big single file app.
This is not bad if you just want to prototype something, but when you start to split the app up into files, you will have the entire responsibility of those architecture decisions on you.
Flask is better suited to very small codebases that have a single function and are maintained by small teams.
If you plan to spin up a lot of microservices, for example, then this can be a good fit.


# What To Take Away

## Django is best suited to: 
- Quickly validating business ideas.
- Ecommerce sites with standard features.
- Information systems in which reporting is important.
- Medium or Large code bases with small or medium teams maintaining them.

## Flask is best suited to:
- Lightweight applications.
- Microservices.
- Non MVT or MVC projects.
- Small code bases with small teams maintaining them.

# So, which one should you choose?
To properly answer this question, you will need to take all of your project requirements into consideration and make a decision based on them. 
If development speed and getting to the market quickly is your priority, then Django would probably be the better choice for you,
as you get a more complete feature set right out of the box.
If you need a more custom solution or your project features are out of the ordinary, then Flask might be the better choice to help achieve this.
At the end of the day, you should choose the framework that is more suited to your project idea and particular situation, while also
taking into consideration their strengths and weaknesses, not only code-wise but also if the coding style is best suited to your organization.

Do you have any experience that you want to share with any of these frameworks?
Are there any additional pros or cons that you feel we didn't discuss here?
If so, I invite you to discuss them in the comment section.

I hope this post was beneficial to you and thanks for reading.
 
