# Django or Flask which one is should you choose your project?
Django and Flask are among the most popular Python web frameworks.
In this article we're going to review their main strengths and weaknesess to help you decide wich one is the better fit for your project.


# Django

## Approach
Django opts for an all batteries included approach.
This means that we have everything we need to build our project included into the framework
from a powerful ORM to an authentication system or a templating engine.
Django takes care of it all without the need to learn any extra libraries.

It also has the concept of plugabble apps, that means that you can drop an app folder inside your project and get it's functionality right away
with very little configuration.

## Main features
- Django has a very powerful ORM that exposes a lot of SQL to the python programming language.
- Authentication and Authorization built in, without any extra configuration
- A built in admin site
- A built in mailing system.

## Pitfalls
- Tightly coupled with it's toolset, django it's sort of difficult to use in combination with other tools (replacing the form library for example)
- The default scafolding, while not bad for small projects, does not scales without modification when trying to manage things such as multiple environments.
- It implements the Model View Template pattern, and requires some effort to implement other architecture types with it


# Flask

## Approach
Born as a combination of an http server with a template engine zipped together, Flask opts for a very minimalistic approach.
It provides some minimal structure, but leaves the decisions up to you.
This makes flask very easy to extend with practically whatever you want.

## Main features
- Very ligthweight.
- It requires little to no configuration.
- Not opinionated, you have total freedom to decide the project structure, from a single file to an elaborate folder system.
- When you need some structure, you have blueprints to structure your app.
- Easy to integrate with other python libraries.

## Pitfalls
- Since it's very lightweigth, while the framework itself doesn't need any special configuration, the used libraries often do require config.
- You have to mix and match libraries to get the desired functionality this also means that different parts of your project have different support from the community.
- The lack of opinion can lead to complicated architectures, or to very big single file projects.

# Wrapping up

## Django is a good idea for…
- Quickly validating business ideas
- Ecommerce sites with standard features
- Information systems in general where reporting is important

## Flask is a good idea for…
- Lightweight applications
- Microservices
- Non MVT or MVC projects

#So?, Wich one should i choose?
To properly answer this question you need to take into consideration all the project requirements and make a decision based on that.
If development speed is the most important thing because you need to go to the market fast, then Django probably will be the better choice,
since you get a more complete feature set out of the box.
If you need a more custom solution, or your project features are out of the ordinary Flask might be the better choice.
At the end of the day, you should choose the framework that adjusts more into your project idea and particular situation,
taking into consideration their strengths and weaknesess
 
