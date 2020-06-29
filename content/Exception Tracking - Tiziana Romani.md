# Exception Tracking
###### Production exceptions are crucial. We don't want errors encountered by clients or crashes in our application to go unnoticed, so keeping track of them it's a must! 

[![Tulips](https://get.wallhere.com/photo/1920x1200-px-bokeh-fields-flowers-sea-tulips-white-1744269.jpg)](https://wallhere.com/es/wallpaper/1744269)

An increase in software applications needs is appreciable nowadays. People want software to make life easier, thus the user experience must be rated as FFF: friendly, fast, and fine. Easy right? Not.
Every developer wishes their software to work like a charm, but since developers are human (at least for now), it is known that humans make mistakes. 

And mistakes, normally sabotage the user experience... But raise up, what doesn't kill you makes you stronger. 

Best way to go is by keeping this mistakes at bay. By monitoring them, awareness is key. But keeping record of hundreds maybe thousands (hopefully not) of errors, doesn't sound like an easy nor pleasant task. Yet diving through endless lines of logs isn't something you wish to someone, not even your worst enemy. There are easier ways, plenty of tools are awaiting for you to include them in your projects. Exception management tools. 

Honeybadger, Sentry, Rollbar, are just a few names that resonate in this exception monitoring world. And don't take me wrong, they are great! But somehow all of them involve certain budget.  

 >“I think we can build a rocket ourselves.” 
 
Said Elon Musk on the plane back from Russia. 
Pursuing Mars-related dreams, Elon Musk, Adeo Ressi and Jim Cantrell intended to make bussines with a russian company in order to adquire rockets. The original deal consisted of 3 ICBM for US$21M. But in the last meeting, russinans turned that into US$21M per ICBM, along with the taunt: "Oh, little boy, you don’t have the money?"
So... no exactly rockets, but similar words came out of my teammate's mouth.

>"I think we can build an exception monitoring tool ourselves."

And what's more, why not offer it to our whole community? Let's make this Open Source. 

And that is how [ExceptionHunter](https://github.com/rootstrap/exception_hunter) was born. 

[![ExceptionHunter](https://github.com/rootstrap/exception_hunter/blob/develop/app/assets/images/exception_hunter/logo.png?raw=true)](https://github.com/rootstrap/exception_hunter)

### Installation
You can get it as a [gem](https://rubygems.org/gems/exception_hunter) for any of your ruby projects! It is as easy as adding to your gemfile:
```sh
gem 'exception_hunter'
```
and run:
```sh
$ rails generate exception_hunter:install
```

And don't forget to include [devise](https://github.com/heartcombo/devise), in case you intend to use our build-in authentication. 
Oh but if you do, don't worry, we will include it for you. 


Happy tracking.
