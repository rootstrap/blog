![Ruby](images/ruby.jpg)

# Ruby doesn't scale
## Why you should stop blaming a programming language for your low quality work

I've heard too many times that Ruby on Rails (also called Ruby or Rails) doesn't scale. Guess what? Java doesn't scale, .NET doesn't scale, PHP doesn't scale, and Node.js doesn't scale. No programming language scales if you build terrible software with it.

In this article, I focus on Ruby, but the information is valid for almost any programming language. If you typically benchmark Ruby against other languages like Python or C++, it's probably slower in most contexts. 

The *real* question isn't how long it takes or how many resources it consumes to run some algorithms like regex redux, binary tree searches, or reading DNA sequences.

## Scalability questions

* How soon you want to go to the market?
* How can you break down your platform into smaller more cohesive pieces?
* Do you have performance requirements? If yes, what's their ultimate goal? A better UX?
* How do you track your success?
* Are you building a proof of concept? A mission-critical application?
* Is scalability important right from day 0?
* If you succeed, how will your platform evolve? Is user growth an objective?

## Every project is different

The answers to these questions might seem obvious, but they're not. Each of the following project scenarios presents entirely different answers to the scalability questions:

* Create a disposable MVP that needs to go to the market in eight weeks to test a business hypothesis.
* Build an app to support the processes and logic of a well-established business with over 100 million in revenue.
* Create a scalable, high-quality MVP that will be released by a VC-funded startup with a high marketing budget.
* Re-engineer and release a version 2 of an existing platform that's having scalability problems due to high growth of its user base.

To know where you stand, you need to ask the scalability questions in all of these scenarios. In each case, you'll get radically different answers.

## Working with Ruby

I've worked on hundreds of applications in my career. Probably most of the startup work I've done has Ruby on Rails components. And do you know what? It's a fantastic framework for going fast to market with high-quality maintainable code, thanks to the company's strong conventions and standards. Ruby has great tools to change, adapt, and pivot your idea. It's fantastic for most startups who are willing to test their minimum viable product (MVP). In the last few years, we've taken the approach of building APIs and lightweight clients, mostly by using ReactJS.

## Increase your chance of winning

Let's be honest. Most startups fail. But if you go to market fast, you can learn and iterate more quickly. Hopefully, you find a product-market fit before you run out of money. Our job is to make sure a startup doesn't fail because of poor technical execution. We can say that we successfully built a lot of failed startups. But we also built some wildly successful ones.

## Platform scaling

In the best case, a platform might become a sustainable business or move in the direction of an exit because of user growth. At this point, we probably need to scale the platform, which is the best problem to have.
We usually face one of the following two possible scenarios.

### Scale overnight

As engineers, we have lots of tools to scale a platform fast:

* First and foremost, get more hardware. Hardware is cheap; software is expensive. We can scale the database, spin up more servers, and add load balancers.
* Grab low-hanging fruit like paging slow queries, database indexes, and cache.
* Identify pain points and bottlenecks and give specific solutions to each problem.

### Long-term scaling

The answers to the overnight scaling questions can and should be applied to long-term scaling. But there are some more things to consider:

* Identify components that need more advanced and faster scalability, like a high-usage chatroom. You can take a microservices approach and create a highly scalable component with the best technology for a specific need. Examples are Go language, Node.js, or NoSQL databases like Redis. This approach can go a long way.
* Don't be afraid of database redundancy, pre-serialized data, and asynchronous processing.
* If some part of an app won't scale as it needs to, plan a new build of that part by using appropriate technology for the problem.
* Run architecture reviews. Refactor.
* Think about how your application will use cache systems. This usage might have an impact on how you structure web services and data flows. And consider cache at different levels. Examples are frontend or mobile, serialized responses, complex algorithms, and database.
* Take metrics, compare versions, and iterate.
* Automate DevOps, containerize, scale horizontally and vertically.

## Don't blame the language

I've seen small apps run super slow, even though they were built on supposedly fast languages like Python. And I've seen multimillion-user apps run entirely on the top of a Ruby on Rails API.

I've heard first-time founders ask my engineering team to design systems to support one million users concurrently. Why? Do they have huge egos? Or did they tell their unexperienced VCs that the platform will be an overnight success, and millions of users will come out of nowhere? I don't know the answer to those questions. But a requirement based on unrealistic expectations is a huge red flag. *Over-engineering* is extremely dangerous for a company, and it's one of the most common reasons that startups fail.

## Know where you stand

Again, if you know where you stand, you're more likely to be successful. Your programming language of choice won't make or break your startup takeoff. Your architecture, processes, engineering, and business model will.