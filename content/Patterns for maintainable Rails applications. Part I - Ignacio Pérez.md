# How to improve maintainability in Rails applications using patterns. Part I

![Main image](images/rails_patterns.jpg)

## Introduction

Software is constantly evolving, both in specification and implementation. Keeping an extensible and maintainable codebase is therefore crucial in order to deal with these changes quickly and easily. Ruby on Rails comes with a lot of good techniques and patterns out of the box that facilitate this. Nevertheless, some of these are commonly misused or overused and consequently they end up negatively affecting the quality of our code.

In this article I will discuss some of these techniques and their caveats, and patterns that can help you level up your Rails so that you don't fall into these situations. I will also provide code examples and cases where each pattern may be useful.

But first, let’s review some fundamental concepts we will focus on in this article.

## Fundamentals

### SRP (Single Responsibility Principle)

This principle, introduced by Robert C. Martin, states that a class or module should only have one responsibility, which is defined as a single reason to change. This, in other words, means that we should put together the things that change due to the same reason and separate those that change for different reasons. The motivation of this principle is limiting the impact of changes by minimizing the modules or classes where these changes occur.

As our Rails application gets more features, models tend to grow larger and more complex, including responsibilities that should not belong to them, turning into “fat models”. Consequently, the code gets harder to understand and change, becoming a problem for maintainability.

### Low coupling and high cohesion

Coupling is the degree of interdependence between modules. A high interdependency will mean that changes made to one module will have a higher probability of impacting the other modules, so our goal should be to have low coupling. Cohesion refers to how the elements of a module belong together. Cohesive modules are easier to maintain. As the elements within the module are directly related to the functionality that module is meant to have, changes are more localized.

We should “design components that are self-contained: independent, and with a single, well-defined purpose” [1]. In order to reach this, we need to have low coupling and high cohesion. As you may have noticed, this is also part of what the SRP principle means to achieve.

### DRY

“Don’t Repeat Yourself” is a well-known principle, particularly for Rails developers. It is often associated to “avoiding code duplication”, however the concept is much bigger than this. The principle is about reducing knowledge duplication, which is achieved when every piece of knowledge has a single representation. By saying knowledge, we mean the business logic of our application, which is represented through algorithms.

This concept is important because sometimes, thinking our code is not DRY, we end up extracting similar behavior dangerously, while adding unnecessary coupling and complexity to our application.

It’s worth noting that code duplication doesn’t always mean violating DRY principle, however, this by no means implies that we should have redundant code.

### Explicit over implicit

This is a principle which is often underrated. The key in explicitness is that it makes the code easier to understand, which makes it easier to modify. Being explicit means not hiding the behavior of our modules and their methods, in order to make it easy to know how our application really works. Explicitness also allows us to avoid mysterious side effects.

## Overused techniques

One of Ruby on Rails advantage compared to other frameworks is the agility with which features can be delivered, and it partly achieves this due to different patterns such as ActiveRecord, which provides many useful techniques for us to use, like scopes and callbacks. Rails encourages the use of these and as a consequence, they tend to be overused by developers, while there are actually better solutions in some cases.

### Scopes

Scopes allow us to encapsulate commonly used queries into single methods in our ActiveRecord models instead of having this query logic repeated. Scopes are easy to implement and also provide readability to our models. However, they tend to increase the size of models, as it is easy to pollute them with a lot of different scopes. This gets worse when some of these do complex queries, like joins with other tables which couples our model to the other models’ attributes, something we shouldn’t do. It looks like the responsibility of these queries could belong somewhere else, for which the Query Objects pattern will be useful.

#### Query Objects

These are Plain Old Ruby Objects (PORO) that include a model’s query logic. The goal of this pattern is to reduce the responsibility of a model by removing complex queries from it. There are two different versions for this pattern: one in which we create one object per model, and another where we create one per scope we want to extract. The second version will likely be the best choice if we have multiple complex queries.

Imagine we had a e-commerce application and we regularly send emails to users that haven’t visited us recently and users that recently bought products. We may have then a User model with some scopes, looking like the following:

https://gist.github.com/PerezIgnacio/a767c7a024c44464698fa57c623f2a76

The following is an example of this pattern applied to User model:

https://gist.github.com/PerezIgnacio/cee4e706abf50ed707b05adca61acbca

Then we can use it from somewhere else in our code, for example, in a simple task:

https://gist.github.com/PerezIgnacio/01a45bb385afb84b1a8e792360a30696

We generate a public method for each scope. The query object is initialized with an Active Record relation as an optional parameter, and if there isn’t any given as argument, it initializes with all records of the relation. This also allows composition with other query objects and scopes, similar as if we were using scopes.

As you may have noticed, the subscribed scope behavior is repeated inside the query object. Fortunately, we can encapsulate queries or part of complex ones into auto-descriptive methods. For this, we dynamically extend the relation with “private” scopes and then use them in our query object, using `ActiveRecord::QueryMethods.extending` method in our initializer.

https://gist.github.com/PerezIgnacio/b427f353bd8b8bbeb06be7c9e2b222b2

### Nested attributes

With nested attributes we can save the attributes of a record through an associated record. This makes them useful as we can easily create multiple nested records and automatically handle any error.

One issue with nested associations is that we may need to add additional complexity to our controllers. The biggest problem with them, however, is that it restricts the parameters our controllers must receive, and so it unnecessarily couples the frontend to the database. It's weird for the frontend to know how we designed our models, specially if it is a completely separated app, such as React, Ember or Angular apps. We should have an interface for this in the backend, which we can achieve with the Form Objects pattern.

#### Form Objects

A Form Object takes care of the creation of multiple models, attributes mapping and contextual validations. We can define one form object for each form in the frontend. They give more flexibility to the frontend as we can map fields in the forms to the attributes of the records in the database. In addition, the pattern helps to respect the Single Responsibility Principle by removing logic from our models or controllers.

Regarding validations, it's important to make a clear distinction between **data integrity validations** and **contextual validations**. The former is tied to the constraints defined in our database schema and, as they are related to how a model is always persisted, they should stay in the model. The latter consists of validations that are important only in the context of a particular form flow, becoming part of the business logic defined for it, so they should go in the form object. This, for example, allows us to easily require fields in one form that are not necessary in others and ensure that some validations will still be applied for every record created, even if this doesn't happen through a form.

Any changes needed to the forms in the frontend will also be much easier to implement as we should only need to modify the related form object, and any new form related to a model may simply require extending our code.

Continuing the example we used earlier, now the User model has a user_request which is responsible for knowing the filters the user saves when browsing the store.

https://gist.github.com/PerezIgnacio/e1babd9cab20f79131941c142b89b402

Let’s assume that when the user signs up in our site, we also send a nested user_request with the filters. We receive this parameters in our controller and create both associated records in the database. In this case, the sign up controller may look something like this:

https://gist.github.com/PerezIgnacio/b5e5212852fcbcff5b5e9c8e9bc74a2c

This looks clean, user creation is simple because we have `accept_nested_attributes_for` in its model. However we are coupling our frontend to our database, while also forcing them to send the `user_request` param with `_attributes`. Also, if the user model and its associations get more complex we may need to include additional code in the controller and, as we know, controllers should be as thin as possible. As an alternative, we can create a Form object, which could look similar to the following:

https://gist.github.com/PerezIgnacio/da03bb1174565f63d392af570f78b592

As you may have noticed, we need to add more code because nested attributes did things for us that we now have to do manually. However, this code is encapsulated in its own object, so it still is preferable over having code in controllers or models. Basically, the form object must be initialized with the params we receive in our controller and we will map to our models attributes. We define then a save method which is in charge of triggering the model persistence logic.

Like I previously mentioned, contextual validations should go in the form objects. Let's consider that for this form `phone` is a required attribute, while we have some other cases where it isn't. We need to add a presence check to this particular case, and the best place for it is this form object. In our database, however, phones are unique to each user so we keep the uniqueness validation in the model.

All models can also be saved in a transaction, so it rollbacks in case any of the models created has an error. Additionally, we may add code that we want to execute after everything is created correctly, such as triggering a notification.

The controller which uses the form object doesn’t change much. Here is how the form object could be used:

https://gist.github.com/PerezIgnacio/d049e6bbb175de521d8456dcc7daf7e2

In this case particularly, the form has all of its attributes explicitly defined, so there is no need to add strong parameters in our controllers, as we can ensure that there won’t be any additional attribute when persisting our models.

Of course, this is a simple example, and the implementation will probably vary depending of the context where it’s used. Forms can easily get more complex, so in this cases it may be useful to combine this pattern with a Service Object, a pattern I will mention in the next part of this article.

## Summary

In this article I discussed some recurrent problems in Rails applications that techniques provided by the framework introduce. Using these techniques isn’t bad per se, but we tend to add a lot of logic and complexity to our models when using them, which is contrary to the mentality we should adopt. To avoid this, it is necessary that we justify our design decisions based on well established principles and give thought to how these will impact our project in the long term. For this reason, we covered some of the several patterns that can help us to make the appropriate choices for our applications and reviewed principles that are necessary in order to understand the problems these patterns solve.

This article was based on an internal talk given by Santiago Bartesaghi and Leticia Esperón.

## References

[1] The Pragmatic Programmer
