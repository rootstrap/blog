# Link Tracking with StimulusReflex - Part III

In this last part of this series, we'll use what we built before to actually start tracking views. To do so, we'll use [ActionCable](https://guides.rubyonrails.org/action_cable_overview.html) and [CableReady](https://github.com/hopsoft/cable_ready) to broadcast and make changes in our frontend.

![Header image](images/stimulus_reflex.jpeg)

### Redirecting users

Let's start with the simple stuff, when a user follows one of our shortened links, they expect to be redirected to the original URL. To do this, we'll create a new controller and add the corresponding route:

```ruby
# app/controllers/redirections_controller.rb

class RedirectionsController < ApplicationController
  def index
  end
end
```

```ruby
# config/routes.rb

Rails.application.routes.draw do
  # ...
  get '/:path', to: 'redirections#index'
end
```

Remember to add it at the bottom of the block so it does not override any other routes.

With this, the implementation should be pretty straightforward:

```ruby
# app/controllers/redirections_controller.rb

class RedirectionsController < ApplicationController
  def index
    link = ShortenedLink.find_by!(shortened_path: params[:path])
    link.increment!(:views_count)

    redirect_to link.original_url
  end
end
```

We want to use [`#increment!`](https://apidock.com/rails/ActiveRecord/Base/increment!) since it's atomic and we are sure we don't want to run any validations, which would just slow us down.
However, what you really want to do is have a background job to increment
the attribute. That way you are absolutely certain that the redirect will
happen in the least possible time, but that's outside the scope of this article.

With this in place, when people click on a shortened link, let's say `www.sholi.com/58dad962`. they'll
get redirected to the original URL and we'll track one morer view for that link.

### Displaying link views

At this point we could just make a static page and spit out our data, but what's the fun in that?
As a way to show how to pass data from the server to the view, as opposed to what we've been doing until now,
we'll make page views update in real time using CableReady.

To do this, let's first generate a new channel by running:

```bash
bundle exec rails generate channel LinkViews
```

Then we'll change `app/channels/link_views_channel.rb` to just stream from `"link_views"`

```ruby
class LinkViewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "link_views"
  end
end
```

We must now tell our client channel, the Javascript one, to perform CableReady operations
if there are any. You can do that by editing the code inside
`app/javascript/channels/link_views_channel.js` to match the following snippet:

```javascript
consumer.subscriptions.create('LinkViewsChannel', {
  received(data) {
    if (data.cableReady) {
      CableReady.perform(data.operations)
    }
  }
});
```

And don't forget to actually import CableReady at the top of the file

```javascript
import CableReady from 'cable_ready'
```

Let's change our Rails views now to actually show the link's views count.
Go to `app/views/shortened_links/index.html.erb` and add a new column on the table.


```erb
  <div class="col"><b>Original url</b></div>
  <div class="col"><b>Views</b></div>
  <div class="col"></div>
```

And populate it with the right data:

```erb
  <div class="col"><%= shortened_link.original_url %></div>
  <div class="col"><%= tag.span shortened_link.views_count, id: "link-#{shortened_link.id}-views-count" %></div>
  <div class="col">
```

Notice how we wrapped the views count inside a span tag with an id.
We are doing this because we need to tell CableReady to perform operations
later on and for that we require a selector.

So just copy the selector and change `app/controllers/redirections_controller.rb` to look like this

```ruby
class RedirectionsController < ApplicationController
  include CableReady::Broadcaster

  def index
    link = ShortenedLink.find_by!(shortened_path: params[:path])
    link.increment!(:views_count)

    cable_ready["link_views"].text_content(
      selector: "#link-#{link.id}-views-count",
      text: link.views_count
    )
    cable_ready.broadcast

    redirect_to link.original_url
  end
end
```

What's going on here? Well it's pretty simple, we are including `CableReady::Broadcaster`
to be able to broadcast operations. Then we add an operation on the
`"link_views"` channel, you know the one we set to stream from before. The operation
is a text replacement in the node with the id `link-#{link.id}-views-count`,
that's what the `#` symbolizes, and the text is the new views count.

### Conclusion

In the series we learned how to setup StimulusReflex, build CRUD apps on a breeze and track data in real time. All
of this with minimal JS and maximum productivity.

### What's next?

This concludes this series on how to use StimulusReflex, but you can still play around with this project and add more functionality:

- Track the browser from which the user clicked the link
- Track the user's country
- Add charts in real time
- Much more...

Or just start a project of your own and give StimulusReflex a try!