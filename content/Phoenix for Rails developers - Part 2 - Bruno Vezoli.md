# Phoenix for Rails developers: a practical example - Part 2

![Small flame](images/small-flame.jpg)

### Introduction

In the first part of this blog post we talked about how Rails and Phoenix compare on the web layer, if you haven't read it go and check it out. Following on from that, we'll see how data and the business layer are implemented on both frameworks.

### Migrations

Let's start with where the data is defined, migrations. And to refresh the memory, here is an ActiveRecord migration:

```ruby
def change
  create_table :articles do |t|
    t.string :title
    t.text :text
    t.timestamps
  end
end
```

And now Ecto's (Phoenix's ORM):

```elixir
def change do
  create table(:articles) do
    add :title, :string
    add :text, :text
    timestamps()
  end
end
```

Notice the difference? At first glance, it looks like the same thing, but if you take a closer look you'll notice that the first snippet takes an Object Oriented approach while the second one is functional. This makes it very easy to apply our Rails knowledge into this new and exciting framework, we just need to tweak a bit the syntax but the basis is still there. For example, let's add a unique constraint to our article's title.

```elixir
def change do
  create table(:articles) do
    add :title, :string
    add :text, :text
    timestamps()
  end

  create unique_index(:articles, [:title])
end
```

So even though it might be different from the common approach of adding the `index: { unique: true }`, it's still very similar to the way an index is created on an existing table. Mainly because that's what's happening here.

### Models and schemas

Here we find one of the first great differences. While models are the heart of a Rails app, Phoenix only has schemas. These are basically structs that contain the database data, like the table fields and their types. It is also responsible for validating this data and generating error messages. Aside from that, it doesn't know a thing about the database, it does not save update or delete any records. But enough chatter, let's see how they look:

```elixir
defmodule Blog.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :text, :string
    field :title, :string
    timestamps()
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :text])
    |> validate_required([:title, :text])
    |> unique_constraint(:title)
  end
end
```

Don't be scared of all those `|>`, it's just the pipe operator (just like Unix's). It just passes the result on the left-hand side as the first argument of the function on the right-hand side. So for example cast is being called with `article` as its first argument, making the two first lines equivalent to `cast(article, attrs, [:title, :text])`.
Phoenix's solution is once again much more verbose than your standard ActiveRecord:

```ruby
class Article < ApplicationRecord
  validates :title, uniqueness: true
end
```

But let's use this new uniqueness constraint to show another difference between how data is treated, which I think it's one point where Ecto has improved upon its cousin. If you take a look at the `changeset` function on the article schema you'll see that the last line calls the `unique_constraint` function with the article and the name of the attribute with the constraint. All it's doing here is preparing to receive a possible exception from the database, it doesn't do any queries, it just delegates those validations to the database. This is one of Ecto's philosophies, constraint validations belong in the database, which is much more efficient at checking them and which ends up validating them anyway in most systems.

### Contexts

Yes! My favorite part, the business logic. Remember how I said schemas on Phoenix do not call the database but are just a bag of data? Well, you must have wondered where are the database calls, right here on the contexts:

```elixir
defmodule Blog.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.Articles.Article

  def list_articles do
    Repo.all(Article)
  end

  def get_article!(id), do: Repo.get!(Article, id)
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end
end
```

Again, this follows the functional paradigm so all a context does is provide methods to interact with the data and it does so by using the repository pattern. If you are not familiar with the concept, just think of it as an abstraction of your database (or another kind of storage) where you can query, update and create records by sending the necessary data. This pattern allows separating the data from the way it's saved, after understanding that contexts are straightforward to comprehend.

This way of managing the data layer and the business logic opens up a world of opportunities. Assume for example that we have a process for publishing in our blog, so all articles must be reviewed after they are changed and before they are published. We would probably do some validations in our model to only insert it if it's approved, the same would go in our context here. But we also like to allow admins to bypass these validations, a common case, and publish whenever they want. So in Rails we would probably change our code to reflect this new case while in Phoenix we might wish to create a new context altogether.

As with any choice, you always have pros and cons, but I really like the way contexts allow you to avoid polluting a model with different responsibilities. If you've been working on Rails long enough you might notice they have a similar purpose as service objects which the community has embraced and which are a part of our daily development cycle.

### Conclusion

You might be thinking I threw a lot of dirt on Rails and the ways things are done, that I recommend not using Rails anymore and start using Phoenix. This is not one of those "why X sucks and you should migrate all your code to Y", this is one of those "hey look at this cool new tool, you might find it useful/enjoyable". I still use Rails on a daily day basis and love the way it works, there are also many ways to mitigate some of the "bad" things about it, like presenters, services, form objects, and much other stuff.

So if you also like Rails give Phoenix a try, you may struggle with it in the beginning, as with any new technology, but I'm confident it'll grow on you as it did on me. To start learning I recommend the official guides, they are very friendly and complete:

- Elixir: [https://elixir-lang.org/getting-started/introduction.html]()
- Phoenix: [https://hexdocs.pm/phoenix/up_and_running.html]()
