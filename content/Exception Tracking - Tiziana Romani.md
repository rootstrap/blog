# Exception Tracking
Production exceptions are crucial. We don't want errors encountered by clients or crashes in our application to go unnoticed, so keeping track of them is a must! 

[![Tulips](https://get.wallhere.com/photo/1920x1200-px-bokeh-fields-flowers-sea-tulips-white-1744269.jpg)](https://wallhere.com/es/wallpaper/1744269)

An increase in software applications needs is appreciable nowadays. People want software to make life easier, thus the user experience must be rated as FFF: friendly, fast, and fine. Easy right? No.
Every developer wishes their software to work like a charm, but since developers are human (at least for now), it is known for them to make mistakes. 

And mistakes, normally sabotage the user experience... But raise up, what doesn't kill you makes you stronger. 

The best way to go is by keeping these mistakes at bay. By monitoring them, awareness is key. But keeping record of hundreds maybe thousands (hopefully not) of errors, doesn't sound like an easy nor pleasant task. Yet diving through endless lines of logs isn't something you wish to someone, not even your worst enemy. There are easier ways, plenty of exception management tools are waiting for you to include them in your projects. 

Honeybadger, Sentry, Rollbar, are just a few names that resonate in this exception monitoring world. And don't take me wrong, they are great! But somehow all of them involve certain budget.  

 >“I think we can build a rocket ourselves.” 
 
Elon Musk said on the plane back from Russia. 
Pursuing Mars-related dreams, Elon Musk, Adeo Ressi, and Jim Cantrell intended to make business with a Russian company in order to acquire rockets. The original deal consisted of 3 ICBMs for US$21M. But in the last meeting, Russians turned that into US$21M per ICBM, along with the taunt: "Oh, little boy, you don’t have the money?"
So... not exactly rockets, but similar words came out of my teammate's mouth.

>"I think we can build an exception monitoring tool ourselves."

And what's more, why not offer it to our whole community? Let's make this Open Source. 

And that is how [ExceptionHunter](https://github.com/rootstrap/exception_hunter) was born. A simple dashboard, containing exceptions and errors occurred at your application grouped by similarity, along with tags differentiating among web-related, worker-related, and manual. All distributed in different tabs so the lookup is easier. And you might also search through well-detailed independent paginated incidences from each error group.


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

And don't forget to include [devise](https://github.com/heartcombo/devise), in case you intend to use our built-in authentication. 
Oh but if you do forget, don't worry, we will include it for you.


### Motivation
So what exactly drove us to undertake such a project? We don't intend to reinvent the wheel, a wide variety of versions for this tool already exist, as said. Yet in our company, we can perceive a strong and growing open-source culture that we identify with and support. 
We hope that by sharing this project, we can give back to the community and help anyone developing hobby projects and small MVPs, where you may not want to pay for an external service, to get exception tracking right out of the box, without much effort.

If you are interested in the subject, stay tuned for incoming posts where we explain how we built ExceptionHunter from the ground up, along with some technical matters.

Happy tracking.
