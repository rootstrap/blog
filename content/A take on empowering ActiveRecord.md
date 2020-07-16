# A Take on Empowering ActiveRecord

I think we are quite underpowered when it comes to doing queries on Rails, having this in mind I proposed my opinion on how we could improve this and made a PR. I also wanted to share it here to know what others think and maybe get some traction.

![Railroad](images/rail_road.jpg)

## The reasoning behind this idea

The problem I was trying to solve is one I usually face, and I think all of us do, where I have to use raw SQL strings for simple queries like:

```ruby
Post.where('created_at > ?', 1.month.ago)
```

I won't get into why using strings is not ideal but here's a quick example of how this could go wrong:

```ruby
Post.where('created_at > ?', 1.month.ago).joins(:comments)
# run this query and you'll get an ActiveRecord::StatementInvalid (PG::AmbiguousColumn: ERROR:  column reference "created_at" is ambiguous) exception
```

Aside from that I really love Ruby and I'd like to write as much Ruby and as less of any other language as possible.

## Querying with Ruby blocks

My idea of how querying can be enhanced is simple: use a block to build the query just as if you were using `#select` or `#map`.  Here's a quick example on how I imagine that syntax looking:

```ruby
Post.where { |post| post.created_at.gt(1.month.ago) }
```

Wouldn't you agree that's much better than writing/parsing SQL strings? If you know what Arel is, you'll notice that I purposely used its syntax when comparing values. If you don't know what Arel is, a quick explanation is that it's what ActiveRecord uses to build queries under the hood.

I used Arel syntax because I think it's great and I find myself using it a lot in complex queries. I also believe it has become very stable and that it provides great capabilities with a good syntax. Although we could also just alias some comparison methods and have something that looks much more natural:

```ruby
Post.where { |post| post.created_at > 1.month.ago }
```

I mean other ORMs have had this power for years now, here's an example straight from [Sequel](https://github.com/jeremyevans/sequel)'s documentation:

```ruby
Post.where{ num_comments < 7 }
```

The Sequel maintainers describe the block as "magical" but I don't think there's anything magical going on, we are pretty used to using blocks everywhere, [FactoryBot](https://github.com/thoughtbot/factory_bot) and [RSpec](https://rspec.info/) are the first examples that come to my mind, where they've built a great DSL with blocks and the use of `instance_exec`.

## What about associations?

Another thing I find difficult right now is filtering using attributes from two different tables, I'm talking about queries like:

```ruby
Post.join(:author).where("posts.likes > users.age")
```

Which using a block could just be written as:

```ruby
Post.join(:author).where { |post| post.likes.gt(post.author.age) }
```

Notice how on one we have to reference the underlying table name while in the other we could just let Rails figure it out and write code more accordingly to our domain. Just to show another ORM (well technically not an ORM) here's [Ecto](https://hexdocs.pm/ecto)'s take on it:

```elixir
Post
|> join(:inner, [p], a in Author, on: p.author_id == a.id)
|> where([p, a], p.likes > a.age)
```

A bit verbose but I really like the power Ecto gives to the developer.

## Let's take it further

There's much more we could be using on the database side, we could delegate much more to it and speed up our application or use functions that are very powerful and we generally forget about. How about implementing search functionality with Postgres? I think using functionalities like `pg_trgm` should be as easy as

```ruby
Post.where { |post| similarity(post.title, "search string" > 0.78 }
```

And there are a bunch of other functions and functionalities from our DBMS we might be missing out just because we would need to use raw SQL strings to use them.

## How do I get this ActiveRecord block querying syntax?

As I said I took the chance to transform the idea into actual code and made a PR about it. If you want to see how this could be brought to like check out [this PR](https://github.com/rails/rails/pull/39445). And of course, if you have any opinions on this, good or bad, feel free to comment here or on Github.