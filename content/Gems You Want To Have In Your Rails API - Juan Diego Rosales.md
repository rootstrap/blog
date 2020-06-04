# Gems You Want To Have In Your Rails API

Are you new to Rails? Or maybe just looking for any cool gem to use in your new API? Here is a list of gems we have on our Rails API Base that we consider a must-have in every Rails API project.

## The best authentication gem
If you are building a Rails API, then you will probably need token-based authentication and that is when [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) comes in. This gem is built on top of Devise, one of the most popular authentication gems for Rails which you may have already worked with. If that's the case, then you'll get familiar with Devise Token Auth very easily.

With very little setup, this gem provides registration, sign in, sign out and reset password flows out of the box, as well as very useful helper functions. Also, it handles email confirmation if enabled and supports the use of multiple user models, giving you the possibility to manage the authentication of different types of users at the same time using groups.

In comparison to other alternatives available, one of the best perks that comes with Devise Token Auth is the very little effort you have to invest to get things up and running. On top of that, you can also customize the different flows mentioned if you want to offer a different experience, and while this may be a little more challenging, it's not rocket science!

## Handling authorization
I guess authorizing every request on an API can be achieved in the controller, but that is not scalable at all and may ease the introduction of vulnerabilities in an application. Here at Rootstrap, we find [Pundit](https://github.com/varvet/pundit) to be the perfect ally against those issues.

Not only will you have one place in the codebase for the authorization logic, making the system more robust, but also it will help to clean up the controllers, improving the readability.

## How to paginate your index actions
When pagination comes into the discussion, I would definitely recommend [Pagy](https://github.com/ddnexus/pagy). Although it was recently added to our Rails API Base, we have been using it in several projects of the company over the last year or so, and the results have been pretty good! It has proven to be a light gem, which is very fast, customizable and easy to use.

## The best admin for Rails
Most APIs typically need some level of resource administration and for that I would definitely recommend [Active Admin](https://github.com/activeadmin/activeadmin). Despite the fact it can have a steep learning curve, specially at the beginning, due to it's [DSL](https://martinfowler.com/dsl.html), once you get used to it you can have admin pages with CRUD actions for any resource in no time.

Something very important to mention is that Active Admin has a large community and good documentation compared to other administration gems, such as Rails Admin or Administrate. Also, another strong feature is that you can configure the index filters according to your needs and they can be customized to use more that one attribute since they support [Ransack](https://github.com/activerecord-hackery/ransack). 

If you need a custom page, you can have Active Admin render your own partial and you will probably need to make changes in the controller actions. This is not an easy task, but none of the other gems offer anything better.

For some people, one of the downsides could be the design, since Active Admin does not come with a powerful CSS framework out of the box. Luckily, there are many [complementary gems](https://github.com/activeadmin/activeadmin/wiki/Themes) that provide a better looking theme.

## Background processing gems
On the background processing front, I would definitely recommend starting with [Delayed Job](https://github.com/collectiveidea/delayed_job). This is because it easily integrates with Rails, has minimal dependencies, resulting in a fast setup, and it offers a very stable and reliable processing.

If your application scales, you will need a framework which delivers performance and in that case I would recommend switching to [Sidekiq](https://github.com/mperham/sidekiq). Changing the framework should be an easy task thanks to Active Job and you will get awesome benefits from this. Sidekiq is known for its very fast speed, scalability and multithreading potential. By running in memory with Redis, fetching and saving data is much faster than completely relying on the database like Delayed Job, and what's more, you can have a dashboard to monitor the status of the processes.

## Communicating with 3rd party services
Even though you can usually find some good gem that will help you call a third party service, sometimes you need to do that on your own. [HTTParty](https://github.com/jnunemaker/httparty) or [Faraday](https://github.com/lostisland/faraday) are great HTTP clients you can use to make external HTTP requests. They may not be on our base repo, but everytime we need to that in a project they are our go-to options.

## Dealing with file uploads
Active Storage is what we use to handle file uploads, but we noticed that it didn't support base64 attachments. That's why the Rootstrap team developed [ActiveStorageBase64](https://github.com/rootstrap/active-storage-base64), which offers an easy way to support uploading base64 encoded files. So, if you have this need, don't hesitate to check out that awesome gem of ours!

## The best gems for testing
Although it may take some time to get used to the DSL, here at Rootstrap we choose [RSpec](https://github.com/rspec/rspec-rails) for testing. The main reason for this is that it encourages human readable tests, which ends up helping a lot in the development process.

When writing tests you always need to set up database records to create the context, and for this we like to use factories with [Factory Bot](https://github.com/thoughtbot/factory_bot). This gem offers great flexibility, allowing the developer to easily create different scenarios, but also improves the readability as you can easily understand what is going on in the test. Another gem that we find very useful for factories is [Faker](https://github.com/faker-ruby/faker), as it provides an easy way to generate fake data.

Last but not least, if your API relies on third party services you will need stubbing on the external HTTP requests and for this I recommend using [Webmock](https://github.com/bblimke/webmock). If you ask me, I found this gem much simpler and flexible than VCR, for example.

## Keeping the code quality
Finally, every developer wants a good quality codebase and in that sense linters are essential. Here's a list of gems that I strongly recommend:

* [RuboCop](https://github.com/rubocop-hq/rubocop-rails)
* [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices)
* [Reek](https://github.com/troessner/reek) for code smells
* [Bullet](https://github.com/flyerhzm/bullet) for query optimization
* [i18n-tasks](https://github.com/glebm/i18n-tasks) for translations linting

If you are having doubts while setting up your new API you can always check out [Rootstrap's Rails API Base repository](https://github.com/rootstrap/rails_api_base). I think it's a great starting point and you can always customize it to your needs.
