# How to improve maintainability in Rails applications using patterns. Part II

![Main image](images/rails_patterns.jpg)

## Introduction

In the [first part of this article](https://www.rootstrap.com/blog/2020/02/14/how-to-improve-maintainability-in-rails-applications-using-patterns-part-i/) we mentioned some important design principles and how they are not respected when overusing patterns and techniques that come with Ruby on Rails. In this part we will continue discussing more of these and how we can mitigate the problems they cause to maintainability.

## Overused techniques

### Active Record Callbacks

Callbacks are useful as we can place repetitive behavior in a single place when otherwise it would be repeated somewhere else. Also, as they belong to the model we keep the controllers clean. Additionally, we can easily extend our code as they aren’t hard to implement and may not need to modify much of the other code in the model.

Active Record Callbacks however, come with some drawbacks:
- Additional responsibilities to the model, which goes against SRP. In case you don't know what SRP (Single Responsibility Principle) is, it is a principle which states that a class or module should have only one responsibility, which means a single reason to change.
- Implicit behavior, which makes testing it isolated impossible, as we need to call the corresponding callback method (for instance, `create` method). Instantiating the model may also trigger a cascade of callbacks, making testing slower in general.
- Unwanted side effects, particularly when having a lot of callbacks. This is also a consequence of implicitness.
- Once we define a callback, every instance of the model is bound to it. If we want to exclude some of them, we shouldn’t use them, as conditional callbacks are a big code smell.
- They break the linear flow of our code, making testing, debugging and refactoring more difficult. When we run into a problem at controller level or we just want to change its behavior, we start from the controller and keep inspecting methods calls until we reach our model. With callbacks, we also have to know which of these are called, figure out their order and check if they effectively need to be triggered for our instance as they may be conditional.

Using too many callbacks doesn’t seem a really good idea. Fortunately, the Decorator pattern can help us with this. We could also use other patterns such as the Form objects mentioned the previous part of the article, or even Service Object which will be described later on in this article.

#### Decorator

The decorator pattern is a design pattern used to extend the functionality of objects without modifying the behavior of other objects of the same class. This is achieved by wrapping an object with another one that has the desired functionality. We can use this pattern instead of callbacks, providing more explicitness and a better assignment of responsibilities. Additionally, it makes testing easier, as each functionality can be tested directly and without needing to trigger every other callback.

As an example, imagine we added multiple callbacks for when a user is created:

https://gist.github.com/PerezIgnacio/8af85c58f0073abffce46091a28f3ff3

The following would be a simple Ruby approach to this pattern.

https://gist.github.com/PerezIgnacio/7a0e5a003ac1ac02037c68f1c908e27d

If we wanted to delegate all user methods, so that we can do `@user.errors`, `@user.attribute`, we can also use SimpleDelegator.

https://gist.github.com/PerezIgnacio/99fa01fd38d910e95dcd0d36ca67ecb9

From Rails 5.1 onwards, however, we can use a helper called delegate_missing_to, which is recommended instead of the above as it is more explicit.

https://gist.github.com/PerezIgnacio/6467f852d165bc569fb7e746c19184a3

https://gist.github.com/PerezIgnacio/0898975690c8b88937536c54ea36eacd

Regardless of how we implement the Decorator, the controller where the model is created should look like the following:

https://gist.github.com/PerezIgnacio/43badd2cf9bdd1210c999ecae89960aa

In case you have been wondering, the Presenter pattern can be considered a sub pattern of the Decorator pattern, as it has the same intent but focuses on trying to keep the logic out of the view. This is implemented similarly to the examples mentioned, but there are also commonly used gems such as Drapper.

### Inheritance/concerns

I included them together because concerns are basically a form of multi-inheritance. Inheritance is useful, but it must be used properly. It must be thought top-down, as creating specialized versions of a parent class and not as a way of extracting duplicated code from two classes. Possible issues with poorly used inheritance are that we may lose explicitness and if we needed to add a third class we would likely need to make unnecessary changes to the hierarchy.

The same applies to concerns, but the consequences are even worse as models can have multiple concerns. Also, in these cases, finding where a method is defined can be tough.

There are also some common bad practices related to concerns that should be avoided. An example is extracting methods into a concern just to reduce the size of a class. We may be gaining readability from this but we lose explicitness and responsibilities are still in the class, only that they were hidden in another file. Another example are bidirectional dependencies in concerns, which is the same as assuming that a superclass knows the implementation details of its subclasses, something we should avoid. An even worse version of this last case is dependency between concerns. A proper concern should then be free of these dependencies and have a single well-defined responsibility.

Rails encourages the use of concerns and there are lots of articles that promote them, but its wrong use has led to even be considered an anti-pattern. Quoting Bryan Helmkamp, CEO at CodeClimate: “Any application with an app/concerns directory is concerning.” [1]

Should we really use concerns then? Even when taking into account all the considerations mentioned, it is difficult to apply them properly, and using concerns usually means having multiple places where we hide the complexity of our models, making them more difficult to understand and maintain. There isn't really a reason to use them when we have more explicit, representative and scalable alternatives, including any of the patterns mentioned in the article. The choice between these depends on the context they are going to be used, but if it doesn’t seem like any applies, you can go for the Services/Service Objects pattern.

As a side note, we can use concerns to share behavior between controllers and this may make more sense in some cases, however, remember that controllers shouldn't be complex and having many concerns may also be a sign that we have logic we could move somewhere else.

#### Services

This pattern consists in encapsulating a particular logic in a service object. The key benefits of using services is that we can remove responsibilities from our models or controllers and make explicit where that functionality is, while also solving the issues with using concerns that we previously mentioned. We can use this pattern when we have to implement a functionality that is complex, involves multiple models or needs to interact with an external service.

This an example of using a concern for encapsulating some functionality:

https://gist.github.com/PerezIgnacio/f9eb9b8b9cf243453abc909839f843a0

The same example, done with a Service would look like the following:

https://gist.github.com/PerezIgnacio/3d8014da7564e13e529cb55042d3132d

When each service represents only one operation, they are sometimes called Service Objects, becoming a more procedural approach to the pattern. There are many ways to implement these, some prefer to add only one `call` method, so that they can be invoked by `ServiceObject.new.call`.

Services by themselves do not necessarily make our code cleaner. The pattern is not only about extracting a method from a model or controller into another component. We must make sure that it is designed correctly, taking into account the same principles we use for models. There are many good practices related to creating services that extend outside the scope of this article, such as internally handling exceptions, returning responses as attr_readers, and reducing the way they are called to make it even less verbose.

As a side note, know that services can be used together with other patterns we previously covered in order to achieve a better assignment of responsibilities.

### Custom validations in models

Rails built-in validators are really useful for model validations. When validations get too complex, however, we need to implement validations ourselves. It’s really common to include these custom validations in our models as custom methods, believing they belong to the model as other simple validations. The problem with this is that it adds an additional complexity to the models that could easily be encapsulated in its own object. Even Rails guidelines recommend better ways to deal with these cases, using other tools included in the framework. I will mention two of these recommendations.

#### ActiveModel::Validator

To create a custom validator, we must create a class that inherits from ActiveModel::Validator and implements the method `validate` that receives the record as an argument and validates it. It is then used in our models with `validates_with` helper.

What makes them a really good solution is the explicitness they give, as it is intuitive to find where custom validations are located.

https://gist.github.com/PerezIgnacio/030654294e5a129e4ab51a9bcf22669c

#### ActiveModel::EachValidator

Another way of extracting validations is through EachValidators. We need to create a class that inherits from ActiveModel::EachValidator and implement the method validate_each that receives as arguments the record, attribute and value to validate, and performs the validations. They can be used from the model similarly to standard validators and can be combined with these as shown in the following example.

https://gist.github.com/PerezIgnacio/5a5358b69439587dc3d8c5bb3dbf126e

These validators are a more reusable than the first, because they also receive the attribute to validate. If we had this regex validator for an email and we had more than one model with attributes that are emails but have different names, we could easily use the same validator for each attribute.

## Summary

In this article we went over commonly used techniques in Rails and the consequences of overusing them, while describing alternative patterns to each. We justified the use of these patterns based on some principles related to code maintainability such as SRP, which we described with more detail in the first part of the article. The mentioned patterns, when correctly applied, can solve a lot of problems related to the maintainability of our application, but also take into account that in some cases, for example, small projects with small teams, it may not be worth over-engineering it by using all of the patterns.
However, some are really easy to apply and we should start using them as early as possible, especially for big projects, as later on changes become more expensive to make.

This article was based on an internal talk given by Santiago Bartesaghi and Leticia Esperón.

## References

[1] [LA Ruby Conference 2013 Refactoring Fat Models with Patterns by Bryan Helmkamp](https://www.youtube.com/watch?v=5yX6ADjyqyE)
