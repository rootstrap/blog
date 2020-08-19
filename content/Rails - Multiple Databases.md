# ** Rails 6 - Multiple Databases **

![main image](images/databases.jpg)

Rails 6.0 came up with this amazing enhancement, but for most people, I'm aware they think that is a new feature.
In my opinion, both are correct, because the actual state of multiple databases before rails 6.0 was not even useful to consider it a completed feature.

Let's dive into Rails < 6 state, Rails 6 introduced changes and the current roadmap.


## Rails 5 state
ActiveRecord supports multiple databases, but Rails < 6 doesn't provide a way to manage them.
As said you needed to handle everything (yes, everything) in a really manual way, having to create your own tasks for `seeds`, `db:prepare`, `db:migrate`, etc.
Then you needed to create a sort of generator to handle your secondary database migrations following conventions. And finally, as if you hadn't done enough custom work, create an initializer to config your connection to the new database.

So yes, ActiveRecord supported multiple databases, but it was a complete and real mess you didn't want to get into unless really necessary.

## Rails 6.0 state

#### New stuff

- Multiple primary databases and a replica for each

This is amazing, now you can easiliy configure it in your `database.yml` like this
``` ruby
development:
  primary:
    database: my_primary_database
    user: root
    adapter: sqlite3
  primary_replica:
    database: my_primary_database
    user: root_readonly
    adapter: sqlite3
    replica: true
  animals:
    database: my_animals_database
    user: animals_root
    adapter: sqlite3
    migrations_paths: db/animals_migrate
  animals_replica:
    database: my_animals_database
    user: animals_readonly
    adapter: sqlite3
    replica: true
```

Check how you can define your migration paths for each database, and how seem to have the power to have multiple adapters (still working on a POC for this assumption).
An example migration with this would be: `rails g migration CreateCats name:string --database animals` with this output
```bash
  Running via Spring preloader in process 97210
    invoke  active_record
    create    db/animals_migrate/20200819181625_create_cats.rb
```

- Automatic connection switching for the model you're working with

You just need to activate it in your middleware for automatic switching:

```ruby
config.active_record.database_selector = { delay: 2.seconds }
config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
```

You can also manually decide your connection context:
```ruby
ActiveRecord::Base.connected_to(role: :reading) do
  # all code in this block will be connected to the reading role
end
```

- Automatic swapping between the primary and replica depending on the HTTP verb and recent writes

As we are used to in Rails, this comes standardized:

“If the application is receiving a POST, PUT, DELETE, or PATCH request the application will automatically write to the primary. For the specified time after the write, the application will read from the primary. For a GET or HEAD request, the application will read from the replica unless there was a recent write.“

- Rails tasks for creating, dropping, migrating, and interacting with the multiple databases

First big comment, the usual `rails db:create` will now create both databases, as so the usual `rails db:migrate` will migrate both databases too.
You need to specify which database you want to work with like `rails db:create:primary` or `rails db:migrate:secondary` if you want to just modify one.

So for your custom tasks you may need to also specify the desired database you are working with.

#### Pending ones

- Sharding
Right now there are some gems to accomplish this, so until is integrated onto Rails we should keep using gems (no real deal with it)

- Joining across clusters
This is what Rails state:
“Applications cannot join across databases. Rails 6.1 will support using has_many relationships and creating 2 queries instead of joining, but Rails 6.0 will require you to split the joins into 2 selects manually.“

So we just need to wait for rails 6.1!

- Load balancing replicas
This seems an interesting feature, so I hope to see upcoming news for this.

- Dumping schema caches for multiple databases
Right now this is what is stated:
“If you use a schema cache and multiple databases you'll need to write an initializer that loads the schema cache from your app. This wasn't an issue we could resolve in time for Rails 6.0 but hope to have it in a future version soon“

So seems like a trivial issue to solve in upcoming versions


## Rails 6.1 upcoming state

As you may know, rails 6.1 is almost there so I will double-check what was stated to be released for this new version, and what is actually going to be released

Nice open PRs right now:
- [Infer migrations_paths from database name](https://github.com/rails/rails/pull/36886)
- [Sharding + configuration DSL](https://github.com/rails/rails/pull/38721)

So the summary would be:
- Sharding is now a WIP thing and we may hope to see it live in Rails 6.1
- Still waiting for the Joining across clusters (or I missed it in my review)
- Still waiting for load balancing
- Schema caches are now a thing!

## Some personal ideas

I'm a huge fan of non-relational databases, so I would love to see some mixins of MongoDB + Postgres for example. And with this introduced changes I think that the road is prepared enough to start working on a way to properly work with it.
My doubts are more into "Should ActiveRecord really support non-relational databases?" or "Is something more rails work outside ActiveRecord?". Leave your thoughts and I will be more than happy to chat over it :)
