# Link Tracking with StimulusReflex - Part II

In the [first part of this series](TODO: Add link to first part) we took care of setting up our project to use Stimulus Reflex. Now it's time to get our hands dirty and write some code. The first thing we are going to do is take care of managing our shortened links.

![Header image](images/stimulus_reflex.jpeg)

## Creating the model

Let's start with some good old fashioned Rails code, we'll create the migration for our links and the associated model:


```ruby
class CreateShortenedLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_links do |t|
      t.string :name, null: false
      t.string :shortened_path, null: false
      t.string :original_url, null: false
      t.integer :views_count, null: false, default: 0

      t.timestamps
    end
  end
end
```

```ruby
# app/models/shortened_link

class ShortenedLink < ApplicationRecord
  validates :name, :shortened_path, :original_url, presence: true
  validates :shortened_path, uniqueness: true
end
```

Notice how we added some simple validations to make it more fun.

## Listing links

Let's start with the simplest of actions, listing the links. To do so, we'll create the following files:

```ruby
# app/controllers/shortened_links_controller.rb

class ShortenedLinksController < ApplicationController
  def index
    @shortened_links ||= ShortenedLink.all
  end
end
```

```erb
# app/views/shortened_links/index.html.erb

<h1>Shortened Links</h1>

<div class="row">
  <div class="col-8">
    <div class="row">
      <div class="col"><b>Name</b></div>
      <div class="col"><b>Shortened path</b></div>
      <div class="col"><b>Original url</b></div>
    </div>

    <% @shortened_links.each do |shortened_link| %>
      <div class="row">
        <div class="col"><%= shortened_link.name %></div>
        <div class="col"><%= shortened_link.shortened_path %></div>
        <div class="col"><%= shortened_link.original_url %></div>
      </div>
    <% end %>
  </div>
</div>
```

We are also going to add [Bootstrap](https://getbootstrap.com/) styling so it doesn't look so dull. To do this, add the following tag to `app/views/layouts/application.html.erb`

```html
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
```

## The link form

What we did in the last section was pretty normal, huh? So, let's keep going. Now we'll add a button to create new links by stimulating a Reflex. To do so, we add this markup and the corresponding StimulusReflex code:

```erb
# app/views/shortened_links/index.html.erb

<h1>Shortened Links</h1>

<div data-controller="shortened-links">
  <button data-action="click->shortened-links#newLink" class="btn btn-primary">New Shortened Link</button>

  <!-- links table ...-->
</div>
```

```javascript
// app/javascript/controllers/shortened_links_controller.js

import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  newLink() {
    this.stimulate('ShortenedLinksReflex#new')
  }
}
```

Now we should create that Reflex in `app/reflexes/shortened_links_reflex.rb`

```ruby
class ShortenedLinksReflex < ApplicationReflex
  def new
    @form_action = :new
    @shortened_link = ShortenedLink.new
  end
end
````

And change the controller's index action to take default values.

```ruby
  # app/controllers/shortened_links_controller.rb

  def index
    @shortened_links ||= ShortenedLink.all
    @shortened_link ||= ShortenedLink.new
    @form_action ||= :none
  end
```

The only thing left to do is to actually render the form when we need to by adding the following in our `app/views/shortened_links/index.html.erb`

```html
<h1>Shortened Links</h1>

<% if @form_action == :new %>
  <%= render partial: "form", locals: { shortened_link: @shortened_link, form_action: @form_action } %>
<% end %>
```

For the actual form, let's do something special. We don't want to redirect to another page but rather allow creating them on the spot. It seems like a modal it's what we need, but in the interest of using less Javascript and leveraging StimulusReflex we'll take a different approach. You'll get it in a minute.

This idea of using backend-managed modals it's taken from LiveView's modal and I'll admit that the code here is basically a copy paste of that 😅. So let's just add the basic modal markup in `app/views/shortened_links/_form.html.erb`

```html
<div class="live-modal" data-controller="shortened-link-form">
  <div class="live-modal-backdrop">
    <div class="live-modal-content">
      <div class="live-modal-close">&times;</div>
      <h2>New Shortened link</h2>
        
      <%= fields_for(:shortened_link, shortened_link) do |form| %>
          
        <% if shortened_link.errors.any? %>
          <div id="error_explanation">
            <h5><%= pluralize(shortened_link.errors.count, "error") %> prohibited this shortened_link from being saved:</h5>

            <ul>
              <% shortened_link.errors.full_messages.each do |message| %>
                <li><%= message %></li>
              <% end %>
            </ul>
          </div>
        <% end %>

        <div class="form-group">
          <%= form.label :name %>
          <%= form.text_field :name, class: "form-control" %>
        </div>

        <div class="form-group">
          <%= form.label :shortened_path %>
          <%= form.text_field :shortened_path, class: "form-control" %>
        </div>

        <div class="form-group">
          <%= form.label :original_url %>
          <%= form.text_field :original_url, class: "form-control" %>
        </div>

        <button class="btn btn-primary">Save</button>
      <% end %>
    </div>
  </div>
</div>
```

With the needed CSS in `app/assets/stylesheets/modal.css`

```css
.live-modal-backdrop {
    opacity: 1 !important;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: #FFF;
    background-color: rgba(0,0,0,0.4);
}

.live-modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 0 20px 20px 20px;
    border: 1px solid #888;
    width: 80%;
}

.live-modal-close {
    color: #aaa;
    text-align: end;
    font-size: 28px;
    font-weight: bold;
}

.live-modal-close:hover,
.live-modal-close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

```

There's not much to be said here, the only interesting part is `<div class="live-modal" data-controller="shortened-link-form">` where we are actually using a new controller. This is just to decompose our code into more reusable units.

Let's go ahead and add that Stimulus controller in `app/javascript/controllers/shortened_link_form_controller.js` with a method to close the modal

```javascript
import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
  }

  closeModal() {
    this.stimulate('ShortenedLinkFormReflex#close_modal')
  }
}
```

For which we'll clearly need a new reflex in  `app/reflexes/shortened_link_form_reflex.rb` with the following code:

```ruby
class ShortenedLinkFormReflex < ApplicationReflex
  def close_modal
    @form_action = :none
  end
end
```

Pretty reactive, we just need to change a variable, and the `if` we added above will automatically stop rendering the modal by not sending the HTML to the frontend. This is very neat in my opinion.

Next up we just bind the closing action on the `X`.

```html
<div class="live-modal-close" data-action="click->shortened-link-form#closeModal">&times;</div>
```

And on the backdrop:

```html
<div class="live-modal-backdrop" data-action="click->shortened-link-form#closeModal">
```

But we also need to trap the click so that it doesn't close when clicking inside. So we just add this method to trap that - `app/javascript/controllers/shortened_link_form_controller.js`

```javascript
  trapClick(e) {
    e.stopPropagation()
  }
```

And bind it in the view:

```html
<div class="live-modal-content" data-action="click->shortened-link-form#trapClick">
```

Also, just for fun, let's also close the modal when the exit key is pressed:

```html
<div class="live-modal"
     data-controller="shortened-link-form"
     data-action="keydown->shortened-link-form#handleKeyDown"
>
```

```javascript
  handleKeyDown(e) {
    if (e.key === 'Escape') {
      this.closeModal()
    }
  }
```

Cool! Now we have a form inside a working modal and all with just a few lines of Javascript.

## Adding validations

ActiveRecord validations rule! That's why we want to use them as much as possible. To do this, we first need to send the values to the Reflex by binding them in the JS controller and adding a validation action.

```javascript
// app/javascript/controllers/shortened_link_form_controller.js

export default class extends Controller {
  static targets = ['name', 'shortenedPath', 'originalUrl']
 
  // ...

  validate(e) {
    this.stimulate('ShortenedLinkFormReflex#validate', [e.target], this.shortenedLinkParams)
  }

  get shortenedLinkParams () {
    return {
      shortened_link: {
        name: this.nameTarget.value,
        shortened_path: this.shortenedPathTarget.value,
        original_url: this.originalUrlTarget.value
      }
    }
  }
}
```

Again, this means we need to change our `app/reflexes/shortened_link_form_reflex.rb` to handle this.

```ruby
  def validate(params)
    @form_action = :new
    @shortened_link = ShortenedLink.new(shortened_link_params(params))
    @shortened_link.validate
  end

  private

  def shortened_link_params(params)
    ActionController::Parameters.new(params).require(:shortened_link).permit(:name, :shortened_path, :original_url)
  end
```

We need to add the action again or it'll get overridden later in the controller. For now, we can just hard-code it. Then we just need to bind for each attribute.

```erb
<div class="form-group">
  <%= form.label :name %>
  <%= form.text_field :name,
                      class: "form-control",
                      data: {
                          target: "shortened-link-form.name",
                          action: "input->shortened-link-form#validate",
                          reflex_permanent: true
                      }
  %>
</div>

<div class="form-group">
  <%= form.label :shortened_path %>
  <%= form.text_field :shortened_path,
                      class: "form-control",
                      data: {
                          target: "shortened-link-form.shortenedPath",
                          action: "input->shortened-link-form#validate",
                          reflex_permanent: true
                      }
  %>
</div>

<div class="form-group">
  <%= form.label :original_url %>
  <%= form.text_field :original_url,
                      class: "form-control",
                      data: {
                          target: "shortened-link-form.originalUrl",
                          action: "input->shortened-link-form#validate",
                          reflex_permanent: true
                      }
  %>
</div>
```

## Saving the links

As a last step, we just need to add code to actually save the link. First in the `FormController` and then in the `ShortenedLinkFormReflex`:

```javascript
// app/javascript/controllers/shortened_link_form_controller.js

export default class extends Controller { 
  // ...

  save(e) {
    this.stimulate('ShortenedLinkFormReflex#save', [e.target], this.shortenedLinkParams)
  }
}

```

```ruby
class ShortenedLinkFormReflex < ApplicationReflex
  # ...

  def save(params)
    @form_action = :new
    @shortened_link = ShortenedLink.new(shortened_link_params(params))
    if @shortened_link.save
      @form_action = :none
    end
  end
end
```

And then we just need to bind again:

```html
<button class="btn btn-primary" data-action="click->shortened-link-form#save">Create Shortened Link</button>
```

As a last touch, we can also add a flash notice, the markdown here is straightforward:

```erb
<% if flash.key?(:notice) %>
  <p id="notice" class="alert alert-primary"><%= flash[:notice] %></p>
<% end %>

<h1>Shortened Links</h1>
```

Then set the following message after creating the link:

```ruby
  def save(params)
    # ...
    if @shortened_link.save
      @flash_notice = "Shortened Link saved successfully"
      @form_action = :none
    end
  end
```

And that's it, we can now create shortened links!

## Joined sessions

If you open a new incognito session, you'll see there's some funny business going on. When working on one session it will also trigger actions on the other side, so opening a modal will magically make it appear on other users' screens. Like so:

![Joined Sessions](images/stimulus_reflex_joined_sessions.gif)

That's alright, the fix is quite simple, we just need to set a `CableReady` identifier in our `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  before_action :set_action_cable_identifier

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id.to_s
  end
end
```

## Editing and destroying

The first thing we need to do to allow these actions is to actually add the buttons. We can do so at `app/views/shortened_links/index.html.erb`:

```erb
  <div class="row">
    <div class="col"><%= shortened_link.name %></div>
    <div class="col"><%= shortened_link.shortened_path %></div>
    <div class="col"><%= shortened_link.original_url %></div>
    <div class="col">
      <div class="btn btn-secondary">Edit</div>
      <div class="btn btn-danger">Delete</div>
    </div>
  </div>
```

Don't forget to add the following empty call after `Original url`:

```erb
  <div class="col"><b>Original url</b></div>
  <div class="col"></div>
```

And now we can implement the edit action. For that, we need the id on the HTML `app/views/shortened_links/_form.html.erb`:

```erb
<div class="live-modal"
     data-controller="shortened-link-form"
     data-action="keydown->shortened-link-form#handleKeyDown"
     data-shortened-link-form-link-id="<%= shortened_link.id %>"
>
```

And to use it on the StimulusJS controller `app/javascript/controllers/shortened_link_form_controller.js`:


```javascript
  get shortenedLinkId() {
    const id = parseInt(this.data.get('linkId'))
    return !!id ? id : null
  }

  get shortenedLinkParams () {
    return {
      id: this.shortenedLinkId,
      shortened_link: {
        name: this.nameTarget.value,
        shortened_path: this.shortenedPathTarget.value,
        original_url: this.originalUrlTarget.value
      }
    }
  }
```

We also need to add a method to load the link correctly in `app/reflexes/shortened_link_form_reflex.rb`:

```ruby
  def load_shortened_link(params)
    shortened_link = if params[:id].present?
                        ShortenedLink.find(params[:id])
                      else
                        ShortenedLink.new
                      end
    shortened_link.assign_attributes(shortened_link_params(params))
    
    shortened_link
  end
```

There's also the issue of how do we determine the current form of action, to do so we need a simple method:

```ruby
  def determine_form_action
    @shortened_link.persisted? ? :edit : :new
  end
```

And refactor the methods we have to use it:

```ruby
  def validate(params)
    @shortened_link = load_shortened_link(params)
    @shortened_link.validate
    @form_action = determine_form_action
  end

  def save(params)
    @shortened_link = load_shortened_link(params)
    @form_action = determine_form_action
    if @shortened_link.save
      @flash_notice = "Shortened Link saved successfully"
      @form_action = :none
    end
  end
```

The only thing left to do is change the modal's title according to the action `app/views/shortened_links/_form.html.erb`:

```erb
<% if form_action == :edit %>
  <h2>Edit Shortened link</h2>
<% else %>
  <h2>New Shortened link</h2>
<% end %>
```

Destroying a record should be pretty simple, so I'll just show you the code. Change `app/views/shortened_links/index.html.erb`:

```html
<div class="col">
  <div class="btn btn-secondary" data-action="click->shortened-links#editLink" data-link-id="<%= shortened_link.id %>">Edit</div>
  <div class="btn btn-danger" data-action="click->shortened-links#destroyLink" data-link-id="<%= shortened_link.id %>">Delete</div>
</div>
```

Bind it in `app/javascript/controllers/shortened_links_controller.js`:

```javascript
  destroyLink(e) {
    if (confirm('Are you sure you want to remove this link?')) {
      const linkId = parseInt(e.target.dataset.linkId, 10)
      this.stimulate('ShortenedLinksReflex#destroy', linkId)
    }
  }
```

And add the method in the Reflex `app/reflexes/shortened_links_reflex.rb`:

```ruby
  def destroy(id)
    ShortenedLink.find(id).destroy!
    @flash_notice = "Shortened Link destroyed successfully"
  end
```

## Up next

We've learned how to do the basic CRUD operations that can be applied to any domain. All that's left is actually tracking the views which we'll cover in the next and last part of this series. And as always, here's a link to [the complete code on this post](https://github.com/brunvez/sho_lin/commit/e894853507149422530fc2a1315dcb8ae64289cc):
