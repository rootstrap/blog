## Access the world's most powerful retail APIs with Best Buy Ruby

### _What's Best Buy Ruby?_

Best Buy Ruby is a new gem developed entirely here, at Rootstrap. It's basically a wrapper for the different [Best Buy APIs](https://bestbuyapis.github.io/api-documentation/). It offers a simple and intuitive interface that allows users to access the required API with as much customizations as they like.

### _Why use it?_

Best Buy offers a really powerful API. The different options provided range from pagination and sorting methods to incredibly flexible item queries and response formats.

But _with great power, there must also come great responsibility_.

While all these options are great, they can make requests quite messy to build. When you find yourself having to add the API key, the response format, page and page size, all this with a couple of conditions in the search query, building the URL can become quite troublesome.

Most healthy projects working with this API must build some kind of module to manage these options, even when the amount of interactions made with the API are low.

And that's where best_buy_ruby comes to save the day.

It's built entirely around the goal of making the API both easily accessible and fully customizable at the same time.

Let's see a quick example:

With the gem, this request:

```
https://api.bestbuy.com/v1/products(categoryPath.id=some_id&(condition=new|new=true))?format=json&page=5&pageSize=100&apiKey=SOME_API_KEY
```

Can be written like this:

```ruby
BestBuy::Products.new.get_by(
    category_id: some_id,
    item_contidion: 'new',
    pagination: { page: 5, page_size: 100 }
)
```

### _Great, I want it. Where can I find it?_

The gem is available in [RubyGems](https://rubygems.org/gems/best_buy_ruby), but be sure to check our own [Github repo](https://github.com/rootstrap/best_buy_ruby), where you'll find the docs to learn how to use it. But of course anyone is welcomed to submit any issues or contribute!
