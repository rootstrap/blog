## Rails N + 2 queries

We usually try to solve performance problems by using `#includes` to get rid of N + 1 queries but this doesn't
always get rid of those extra queries; in fact it can even create more queries under some circumstances. This post
shows some examples of when that happens and how to deal with it.

![Forest with bridge](images/forest_bridge.jpg)

### Your typical N + 1 query problem

We learn how to deal with ActiveRecord performance issues with very plain examples, most blog posts show models that
look something like this:

```ruby
class Post < ApplicationRecord
  has_many :comments
end

class Comment < ApplicationRecord
  belongs_to :post
end
```

Followed by your standard `irb` example:

```ruby
irb> posts = Post.all
irb> all_comments = posts.map { |p| p.comments }
```

Which generates the following queries, where we can clearly see an N + 1 query since it needs to fetch comments for each
post:

```
Post Load (0.5ms)  SELECT  "posts".* FROM "posts"
Comment Load (0.8ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1  [["post_id", 1]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1  [["post_id", 2]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1  [["post_id", 3]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1  [["post_id", 4]]
Comment Load (0.6ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1  [["post_id", 5]]
```

And that the solution is to preload the data by calling the `#includes` method over the posts collection

```ruby
irb> posts = Post.includes(:comments)
irb> all_comments = posts.map { |p| p.comments }
```

Which in turn produces the following, much optimized, queries:

```
Post Load (0.5ms)  SELECT  "posts".* FROM "posts"
Comment Load (1.4ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN ($1, $2, $3, $4, $5)  [["post_id", 1], ["post_id", 2], ["post_id", 3], ["post_id", 4], ["post_id", 5]]
```

And so we start using `#includes` on all our ActiveRecord queries and move on.

### A little ways down the road

Time passes and requirements change, it's only normal. Now we need to only show posts that are uncensored and we change
our query to reflect that:

```ruby
irb> posts = Post.includes(:comments)
irb> all_comments = posts.map { |p| p.comments.where(censored: false) }
```

Can you guess the amount of queries this is going to generate? I'll give you a hint: it's on the name of the post.

```
Post Load (0.5ms)  SELECT  "posts".* FROM "posts"
Comment Load (1.4ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN ($1, $2, $3, $4, $5)  [["post_id", 1], ["post_id", 2], ["post_id", 3], ["post_id", 4], ["post_id", 5]]
Comment Load (6.4ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 1], ["censored", false]]
Comment Load (0.5ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 2], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 3], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 4], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 5], ["censored", false]]
```

Now we have the N + 1 queries we had in the beginning and also an additional query to preload data we are not going to use
(which will increase our application's memory footprint but that's a story for another day)

### Let's add Bullet duh

I agree that [bullet](https://github.com/flyerhzm/bullet) is a must have in any project, no matter how big or small. It's
very difficult to catch every N + 1 query we build and it's even harder to detect cases like this where we should no longer
preload the data.

After installing bullet what we get is the following warning: 

```
AVOID eager loading detected
  Post => [:comments]
  Remove from your query: .includes([:comments])
```

Awesome! It knows about our unused preload and it tells us to remove it; let's do that.

```ruby
irb> posts = Post.all
irb> all_comments = posts.map { |p| p.comments.where(censored: false) }
```

And let's also check our logs for the generated queries and watch out for warnings from bullet.

```
Post Load (0.5ms)  SELECT  "posts".* FROM "posts"
Comment Load (6.4ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 1], ["censored", false]]
Comment Load (0.5ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 2], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 3], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 4], ["censored", false]]
Comment Load (0.2ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 AND "comments"."censored" = $2  [["post_id", 5], ["censored", false]]
```

So we are back to square one but this time we have no bullet warnings, so what should we do?

### Solution: scoped associations

There are two solutions (at least that I know of) to this performance problem. The first one is to use [Rails' preloader](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/associations/preloader.rb#L45)
but as you may guess from the `:nodoc:` directive that's a private class not meant to be used outside the framework. I'm not going
to even talk about how to preload using that class but if you are curious here's [a nice post](https://blog.rstankov.com/dealing-with-n-1-with-graphql-part-1/)
on how to deal with N + 1 queries on GraphQL using Rails' preloader.

The second solution, and the one I'm going to explain here, it's using a scoped association and preloading it instead of the
`comments` association. This requires us to add one more line to our Posts model:

```ruby
class Post < ApplicationRecord
  has_many :comments
  # we need to specify a new name, a lambda to filter the comments and the model class name
  has_many :uncensored_comments, -> { where(censored: false) }, class_name: 'Comment'
end
```

And change our code to get the comments using the association:

```ruby
irb> posts = Post.all
irb> all_comments = posts.map { |p| p.uncensored_comments }
```

Bingo! We get the following warning from bullet:

```
GET /posts
USE eager loading detected
  Post => [:uncensored_comments]
  Add to your query: .includes([:uncensored_comments])
```

And sure enough if we add that preload

```ruby
irb> posts = Post.includes(:uncensored_comments)
irb> all_comments = posts.map { |p| p.uncensored_comments }
```

We no longer get the warning and our queries are optimized:

```
Post Load (0.5ms)  SELECT  "posts".* FROM "posts"
Comment Load (0.9ms)  SELECT "comments".* FROM "comments" WHERE "comments"."censored" = $1 AND "comments"."post_id" IN ($2, $3, $4, $5, $6)  [["censored", false], ["post_id", 1], ["post_id", 2], ["post_id", 3], ["post_id", 4], ["post_id", 5]]
```

### Caveats

As with most performance optimizations you should really measure and evaluate the changes you are about to make. It doesn't
really make sense to add an association to your models every time you want to preload, sometimes is better to have a small
performance penalty rather than a model full of associations.

But if your queries are taking too long I really encourage you to add the corresponding associations and preload the data you need.


#### Bonus

This method also works for cases when you need to just fetch one record. Let's use the blog example and add a use case where
we need the most liked comment from each Post:

```ruby
irb> posts = Post.includes(:comments)
irb> most_liked_comments = posts.map { |p| p.comments.order(likes: :desc).first }
```

Once again we have an N + 1 and no warning from bullet

```
Post Load (0.4ms)  SELECT "posts".* FROM "posts"
Comment Load (0.9ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 ORDER BY "comments"."likes" DESC LIMIT $2  [["post_id", 1], ["LIMIT", 1]]
Comment Load (0.7ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 ORDER BY "comments"."likes" DESC LIMIT $2  [["post_id", 2], ["LIMIT", 1]]
Comment Load (0.6ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 ORDER BY "comments"."likes" DESC LIMIT $2  [["post_id", 3], ["LIMIT", 1]]
Comment Load (0.3ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 ORDER BY "comments"."likes" DESC LIMIT $2  [["post_id", 4], ["LIMIT", 1]]
Comment Load (0.4ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."post_id" = $1 ORDER BY "comments"."likes" DESC LIMIT $2  [["post_id", 5], ["LIMIT", 1]]
```

And here is where `has_one` comes to the rescue, let's modify our Posts model one last time

```ruby
class Post < ApplicationRecord
  has_many :comments
  has_many :uncensored_comments, -> { where(censored: false) }, class_name: 'Comment'
  # rails will automatically limit the number of records for us
  has_one :most_liked_comment, -> { order(likes: :desc) }, class_name: 'Comment'
end
```

Bullet now complains about data not being preload us and gives us the solution to our problems

```ruby
irb> posts = Post.includes(:most_liked_comment)
irb> most_liked_comments = posts.map { |p| p.most_liked_comment }
```

And we get neat SQL queries once more

```
Post Load (0.4ms)  SELECT "posts".* FROM "posts"
Comment Load (0.4ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN ($1, $2, $3, $4, $5) ORDER BY "comments"."likes" DESC  [["post_id", 1], ["post_id", 2], ["post_id", 3], ["post_id", 4], ["post_id", 5]]
```

Notice though that in this case we don't get the limit on the query and so Rails loads all these comments on memory and then
loads them on each post, that's also something to consider: memory usage vs SQL query time. As in most cases there's not a clear
answer and you should really measure to see your specific case.
