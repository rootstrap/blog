[![YAAF](images/Yaaf-Blog-cover.png)](https://github.com/rootstrap/yaaf)

# Form object patterns in Rails: Stop creating services for everything with YAAF

## Working with large controllers

How many times have you encountered large controller methods? If you are _lucky_ like me, probably many times.

One of the most common practices to start refactoring a long controller is to move the code to a service.

Services are great, and if we code them in an atomic way, they will be easy to test and understand. But the problem is when we use the services it's like using a _Swiss Army knife_.

>-"Hey, I don't know how to properly refactor this piece of code"
>-"Dude, just do a new service"

**But no!**, making a new service is not always the best option. In some cases, we are _reinventing the wheel_ and maybe there is a pattern that already fits with our needs.

So here comes **YAAF** (Yet Another Active Form) to save our day. **YAAF** is a gem that lets you create form objects in an easy and friendly Rails way. It makes use of `ActiveRecord` and `ActiveModel` features in order to provide you with a form object that behaves pretty much like a Rails model and still be completely configurable.

## When to use YAAF?

Let's imagine that we have an API endpoint that saves a new post on our database. A post has a title, body, publisher, and could also have tags and a category.

Tags and categories could be created at the moment that the publisher sends the post. (If our inputs don't find the correct tag or category, they will let the user write the name of a new one).

So, in the worst-case scenario, our controller could have something like this:

```ruby
class Api::V1::PostsController < Api::V1::ApiController
  def index
    @posts = Post.all
  end

  def create
    ActiveRecord::Base.transaction do
      @post = Post.new(post_params)
      @post.tags = params[:tags].map do |tag|
        tag[:id].present? ? Tag.find(tag[:id]) : Tag.find_or_create_by(name: tag[:name])
      end
      if params[:category_name].present?
        category = Category.create!(name: params[:category_name])
        @post.category = category
      end
      @post.save!
    end
  end


  def post_params
    params.require(:post).permit(:title, :body, :publisher_id, :category_id)
  end
end
```

It looks terrible, right? Maybe our first thought about that piece of code is to make a refactoring that moves the creation of the post to a service named `PostCreationService`. This could be useful and might be used in the future in another part of the system. But, what have we said about _reinventing the wheel_?

When using **YAAF**, we should create a new `PostForm` class that is going to encapsulate all the logic of post creation and related models inside it. And it is very simple to implement it! Just look at this code:

```ruby
# app/forms/registration_form.rb

class PostForm < ApplicationForm
  attr_accessor :post_form_params
  validate :amount_of_tags

  def initialize(args = {})
    @post_form_params = args
    @models = [post, category, tags].flatten.compact
  end

  def post
    @post ||= Post.new(post_form_params[:post]).tap do |post|
      post.category = category
      post.tags = tags
    end
  end

  def category
    return [] if post_form_params[:category_name].blank?

    @category ||= Category.find_or_initialize_by(name: post_form_params[:category_name])
  end

  def tags
    return [] if post_form_params[:tags].blank?

    @tags ||= post_form_params[:tags].map do |tag|
      tag[:id].present? ? Tag.find(tag[:id]) : Tag.find_or_initialize_by(name: tag[:name])
    end
  end

  private

  def amount_of_tags
    return if tags.size.between?(1, 3)

    errors.add(:base, "You can't assign more than three tags to a post")
  end
end
```

**Note:** We have also added a custom validation named `amount_of_tags`, YAAF helps us to encapsulate business rules in our Form Object.

And then in our controller, we have the following:

```ruby
class Api::V1::PostsController < Api::V1::ApiController
  def index
    @posts = Post.all
  end

  def create
    form = PostForm.new(post_form_params)
    form.save!
    @post = form.post
  end

  private

  def post_form_params
    params.permit(:category_name, tags: %i[id name], post: %i[title body publisher_id category_id])
  end
end
```

**Tip:** Having an `ApplicationForm` which inherits from `YAAF::Form` is a good practice.

That's it, now we have a `PostForm` which encapsulates all the persistency logic of post/tags/categories, leaving our controller and models clean and the code is easy to follow.

Another good thing is that **YAAF** provides a similar API to `ActiveModel` models so you can treat them interchangeably.

## Why not a Service or PORO's?

- **Making customized Services or PORO's could be disorganized** if you're working in a team.
- YAAF helps you to apply the **Form Pattern** in an easy way.
- YAAF is only **64 lines long**.
- It's **well tested and maintained**.
- It helps you keep your models, views, and controllers thin by providing a better place to put business logic. In the end, this will **improve the quality of your codebase and make it easier to maintain and extend**.
- And a lot **[more](https://github.com/rootstrap/yaaf)**.

## Summary

Well, if you come along this way I hope this article helps you to integrate **YAAF** in your project and start using the `FormObject` Pattern to make your code even better. You can see more examples **[here](https://github.com/rootstrap/yaaf)**. **YAAF** is open-source and is open to receive new contributions, so check it out!
