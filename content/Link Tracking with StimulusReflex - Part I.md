# Link Tracking with StimulusReflex - Part I

This is the introduction to a series on using StimulusReflex, a new tool to bring Rails to the
era of the backend-side-managed frontends. This might sound weird but there's been a couple of projects, starting with [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) and following with things like [Motion](https://github.com/unabridged/motion) and [Sockpuppet](https://github.com/jonathan-s/django-sockpuppet), which use WebSockets to push updates from the server to the client and update the DOM accordingly.

This is better defined by the [StimulusReflex's folks](https://docs.stimulusreflex.com) which as you may have guessed is a gem that does just that. I'm not going to explain this any further in words but rather I'll show you how to use it by building a link shortener with this
new and exciting technology. In this part of the series, we'll focus on getting up and running so we can build awesome features for our project.

![Header image](images/stimulus_reflex.jpeg)

## Initializing the project

To get started we are just going to follow the [original docs](https://docs.stimulusreflex.com/setup) and run the default `rails new` generator preconfigured to use [StimulusJS](https://stimulusjs.org) as the Javascript backend and the name of our project (`sho_lin` is short for **Sho**rtened **Lin**k, get it? I promise it's the first and only pun):

```bash
rails new sho_lin --webpack=stimulus -d postgresql
```

By the way, StimuluJS is a frontend framework concerned with adding functionality to the HTML rather than controlling the whole DOM. If you wish to learn more about it, there's a [recent post](https://www.smashingmagazine.com/2020/07/introduction-stimulusjs/) that explains how it works.

## Testing that StimulusJS works

Even though this framework deserves a more in-depth explanation, let's do a quick example to make sure everything works as expected and have a basic idea of how it works.

First, we'll create a basic controller with an index action to just render some HTML

```bash
rails g controller pages index
```

And we'll make this action our new root in our `config/routes.rb`

```ruby
# change
get 'pages/index'

# to
root 'pages#index'
```

And we'll dive into some Javascript as well by changing the `HelloController` in `app/javascript/controllers/hello_controller.js` for the following class

```javascript
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output"]

  sayHello() {
    this.outputTarget.textContent = "Hello, Stimulus!"
  }
}
```

Now we just need to bind it to our markup in `app/views/pages/index.html.erb` by using some
data attributes

```html
<div data-controller="hello">
  <button data-action="click->hello#sayHello">Say hello</button>
  <h1 data-target="hello.output"></h1>
</div>
```

Now if you run the server with `rails s` and go to `http://localhost:3000` you'll see that when you click on the "Say hello" button you'll get back "Hello, Stimulus!". I think the code it's pretty self explanatory but I'll give a quick walkthrough anyway.

Here we are just telling StimulusJS to hook the controller prefixed with `Hello` scoped to that HTML tree. That will start looking for specific data attributes which in this case are `data-action` and `data-target`. The first accepts a syntax to call specific methods on the instance of the controller on a given event, currently set to invoke the `sayHello` method when the click event occurs. The latter binds the text to a target, which is just like a reference to the element but more at the same time, keeping them synchronized.

So in this case when we set the `textContent` of our `outputTarget` the text will immediately appear on our `h1` tag. Keep this concept in the back of your mind since we'll keep using it throughout the series.

## Adding Reflex to our previous example

Now that we've seen how StimulusJS works let's get down to business. The first step is to install it, which is extremely simple

```bash
bundle add stimulus_reflex
bundle exec rails stimulus_reflex:install
```

Then let's do some changes to the generated code by renaming `app/reflexes/example_reflex.rb` to `app/reflexes/hello_reflex.rb` and adjust the code inside as well


```ruby
# change
class ExampleReflex < ApplicationReflex

# to
class HelloReflex < ApplicationReflex
```

And add a handler method called `#greet` to differentiate it from our frontend binding

```ruby
  def greet
    @message = 'Hello, StimulusReflex!'
  end
```

And change the `h1` tag in `app/views/pages/index.html.erb` to show our message

```html
<h1><%= @message %></h1>
```

You *DO NOT* need to add the `@message` variable in the `PagesController`. If you do set it remember to use the `||=` operator like `@message ||= "Some default"` since otherwise it would override the Reflex's value.

Now we'll adapt our frontend to call the HelloReflex by updating the HelloController in `app/javascript/controllers/hello_controller.js` to use StimulusReflex.

First import `StimulusReflex`

```javascript
import StimulusReflex from 'stimulus_reflex'
```

Then register the controller in the connect function

```javascript
  connect() {
    StimulusReflex.register(this)
  }
```

And finally, change the `sayHello` function to call the Reflex on the server

```javascript
  sayHello() {
    this.stimulate('Hello#greet')
  }
```

Tho whole file should look like this:

```javascript
import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect() {
    StimulusReflex.register(this)
  }

  sayHello() {
    this.stimulate('Hello#greet')
  }
}
```

You can test it again and you should get back "Hello, StimulusReflex!". How did it happen? Behind the scenes, StimulusReflex opens up a WebSocket connection and runs the Reflex's action and then the Controller's action sending the resulting HTML over the wire. On the client's side it does a diff between the result and the current DOM performing the minimum updates to update the latter.

## Up next

We now have a basic Hello World example up and for which you can see the whole code on these [two](https://github.com/brunvez/sho_lin/commit/7a7a81f8c702d7d15402bf54ef49c701ed3ac46e) [commits](https://github.com/brunvez/sho_lin/commit/e3dd684bd6c00eca4d847bbf7f70d0cefe4e8a26). In the next part, we'll add some code to list and manage our links all with the best features from Rails. So keep posted!
