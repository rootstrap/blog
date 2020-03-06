# Phoenix for Rails developers: a practical example - Part 1

![Small flame](images/small-flame.jpg)

This is an introductory post to Phoenix, Elixir's web framework. It is not intended to be a complete guide since it’s a big framework with lots of things to dive into, but rather to show a side by side comparison of how things are done in both frameworks using the scaffolding they provide to throw some insight into their best practices with a classic blog example.

It is a two-part blog post, in the first half we'll take a look at the web layer where both frameworks are most alike and in the second half, we'll dive into the business layer which is where the frameworks diverge.

The idea is to show how similar they are and get you hyped enough to try it yourself!

### Introduction

I started working on Ruby after an exploratory phase of many languages led me to it. The syntax just captivated me, it was so expressive that it could be read like English and it had so many tools that allowed me to do things more productively than ever before. No more string helper functions or awkward loops to manipulate arrays, you could have all those things out of the box and just focus on coding your solution. After a while I found Rails, and it felt right in with Ruby’s philosophy. I felt much more productive than with other tools and it came with batteries included. No hours of configurations or research for a library that just required you to do all the work.

Since that time I’ve tried many other web development frameworks in a wide variety of languages but I never felt at home with any of them. Even if many tried to replicate what Rails did there was always something missing, whether it was because of the language or some decision where it diverged they always felt like mere copies to me.

### Phoenix

Enter Phoenix, a web framework built on top of Elixir, a functional language with a Ruby-like syntax that runs on top of the Erlang virtual machine. This framework took after many of the features that make Rails what it is: MVC architecture, an opinionated file structure, included tools such as an ORM, a template engine and a routing layer. But it never tried to be another copy, instead, it diverged with time and took many decisions that fit better the functional paradigm and the different language, all without sacrificing productivity or developer happiness.

In time, this led to an independent web framework but with that special flavor we all love from Rails. There’s one difference though, since Elixir was built on top of Erlang, which was designed to build massively scalable applications, all apps built with Phoenix inherit this perk. This means that you can code away without having to worry about how your app will perform once you reach the big leagues. This is something with which many Rails apps struggle and it’s the main reason why Jose Valim developed Elixir in the first place.

But enough preaching, let’s see it in action!


### File structure

No opinionated framework would be complete without a take on how files should be organized. So let's first take a look at how things look from the folder view. This is what you get when you generate an app with both frameworks:

![File structure comparison](images/phoenix-rails-project-structure.png)

Phoenix's structure inherits from how packages (Elixir's equivalent for gems) are structured, all custom code goes inside the `lib/` folder. Inside it you'll find right away the main difference between both frameworks in this aspect: Phoenix separates the layer of web presentation from the business logic. In the image above, we have a `blog/` folder, which contains the basic modules to build our business logic and the `blog_web` which looks pretty similar to the Rails' `app/` directory. There are some subtle differences though but we'll take a deeper look into the them in the following sections.

### Scaffold away

As I mentioned, both frameworks provide commands to scaffold different parts of the application. For this example, we'll compare the output of generating a full resource including views and routes, but first, the commands used:

```bash
bin/rails generate scaffold Article title:string text:text
```

```bash
mix phx.gen.html Articles Article articles title:string text:text
```

Once more they look alike with subtle differences, in this case, Phoenix goes for a more verbose fashion by asking us to specify the context module where it'll be created, the name of the schema module (equivalent to the model) and its plural to be used as the table name.

### Routes

Every web request starts by being routed to the correct handler, let's go with the simple routes first and see how Rails handles this:

```ruby
Rails.application.routes.draw do
  resources :articles
end
```

Rails' routes are pretty straightforward once you get to know them, they just specify which endpoints are available for the end user, allow gems (or more precisely engines and plugins) to mount their routes and some validation like Devise's `authenticate` method. The manipulation of the request is done on the controllers and from time to time it's a bit difficult to know where a value came from, who parsed a request or who rejected it. Phoenix has a different take on this:

```elixir
defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogWeb do
    pipe_through :browser

    resources "/articles", ArticleController
    get "/", PageController, :index
  end

  
  scope "/api", BlogWeb do
    pipe_through :api
  end
end
```

That's a lot more code, but just because there are more responsibilities too. The `plug` calls you see here define something that could be compared to middlewares, they get executed serially in the order they are defined. They get grouped together with the `pipeline` function so they can be called inside scopes (which are just like Rails'), to perform things like parsing, authentication, authorization and pretty much anything else you might want to do before an action gets executed.

This allows decoupling controllers from the logic of authorizing users and rejecting requests most of the time, which substitutes `before_action` calls and, in many cases, reduces the need for complex inheritance between controllers.

### Controllers

Next step is the actual handling, since both fameworks follow the MVC pattern this is done in the controllers. For these I decided just to show some actions and do a quick walkthrough of the differences, there is a lot to understand on functional programming to decipher what's Phoenix doing and this is not the post for that. If you feel interested to learn some more on Elixir's syntax the [Elixir Getting Started Guide](https://elixir-lang.org/getting-started/introduction.html) is a good place to start. Without further ado, I present to you the controllers: 

```ruby
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, 
                                     :edit,
                                     :update,
                                     :destroy]

  def index
    @articles = Article.all
  end

 def new
    @article = Article.new
  end

 def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article }
        format.json { render :show, status: :created, 
                             location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, 
                             status: :unprocessable_entity }
      end
    end
  end
end
```

```elixir
defmodule BlogWeb.ArticleController do
  use BlogWeb, :controller

  alias Blog.Articles
  alias Blog.Articles.Article

  def index(conn, _params) do
    articles = Articles.list_articles()
    render(conn, "index.html", articles: articles)
  end

  def new(conn, _params) do
    changeset = Articles.change_article(%Article{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do
    case Articles.create_article(article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: Routes.article_path(conn, :show, article))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
```

The main difference here is just the programming paradigm. Elixir is functional so the request (or connection) and the params are received as parameters of the action, while Ruby, being object oriented, provides the same data through local state and accessor functions. Still, the syntax is quite similar and I think it's easy to get a grasp of what's going on in the Phoenix snippet. 

Another small difference is that the generator used on Phoenix will scaffold a controller that just responds to HTML, while Rails' will render views for both JSON and HTML. There is, of course, another generator to make a JSON resource but it'll create a new controller which will go on a different pipeline (if you go back to the routes section you'll see there's an `:api` pipeline).

### Helpers and Views

Last but not least is how we present the data on the web layer. You probably noticed in the file structure that there were two directories called `views/` and `templates/` on the Phoenix project structure, if you didn't go and take a closer view. You might be wondering what's the difference between them, well the templates are just that, text files with embedded code (just like erb we have eex) which you use to respond to requests. Views, on the other hand, resemble to helpers but with one noticeable difference: they are not global by default.

Let's take a look at how they differ with an example; we would like to show the read time in our articles. Since we don't track this value on our DB and it's just for presentation you'd normally want to put this on a helper, like this:

```ruby
module ArticlesHelper
  WORDS_PER_MINUTE = 200

  def read_time(article)
    words_count = article.text.split.size
    read_time_in_minutes = words_count / WORDS_PER_MINUTE.to_f
    “#{read_time_in_minutes.ceil} minutes"
  end
end
```

Easy peasy, now we just have to call this on our `show.html.erb` and we are done. Not so fast, the problem I see with this is that it gets included in every view. Sure, for a small app like this and with a name so specific, there's no problem, but when it starts to grow and you have helpers with names like `format_title` and `format_title_for_user` you start having troubles. Phoenix's helpers (or views as they are called in the framework) are very similar:

```elixir
defmodule BlogWeb.ArticleView do
  use BlogWeb, :view

  alias Blog.Articles.Article

  @words_per_minute 200

  defp read_time(%Article{text: text}) do
    words_count =
      text
      |> String.split(" ")
      |> Enum.count()
    read_time_in_minutes = Float.ceil(words_count / @words_per_minute)
    "#{trunc(read_time_in_minutes)} minutes"
  end
end
```

But as I said before they are scoped to some presenter so this view, for example, has functions that can only be called on an article template. This allows you to use whatever name you want knowing you won't pollute the global scope. And what about if you want to use common functions across many templates? Simple, make another module with those functions and include it across the views where you need it.

### Follow up

This concludes the short walkthrough of the difference in the web layer. Next up, in the second part of this post is the data and business layer.



