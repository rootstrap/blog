## Building a SPA using Hotwire

In the past few years, there has been a rise in Single Page Applications ([SPA](https://en.wikipedia.org/wiki/Single-page_application)). Many of the modern web applications tech stack rely on a JSON API in the backend, and a frontend app modifying the DOM in the web browser, creating a fast and seamless experience.

When Ruby on Rails was created, it was developed to render pages on the server, so to build an SPA with Ruby on Rails running on the backend meant rendering JSON payloads as a response, and letting the frontend take care of the rest.

But what if the frontend could update the DOM, sending HTML from the backend instead of JSON?

Here is where [Hotwire](https://hotwire.dev/) comes into action!

![Hotwire](images/hotwire.png)

According to Hotwire:

> Hotwire is an alternative approach to building modern web applications without using much JavaScript by sending HTML instead of JSON over the wire. This makes for fast first-load pages, keeps template rendering on the server, and allows for a simpler, more productive development experience in any programming language, without sacrificing any of the speed or responsiveness associated with a traditional single-page application.

Hotwire was created with the aim of replacing these heavy load JS SPAs with good old HTML to help encourage developers to see the application as a set of frames that can be replaced, or augmented by the HTML sent from the server.

That being said, using Hotwire means mantaining the Ruby on Rails way of programming, as it mostly uses Ruby on Rails views and partials you need to write anyway.

### Hotwire Components

Hotwire consists of these three components:

- Turbo: This is the heart of Hotwire, it consists of a set of techniques for speeding up page changes and form submissions, dividing complex pages into components, and stream partial page updates over WebSocket, without writing any JS code at all.

- Stimulus: Some of the interactivity may need some JS code to work as required, so for those cases where custom code is required, Stimulus makes the work.

- Strada: This component is used to allow mobile hybrid applications to talk to each other via HTML bridge attributes. At the time of writing, Strada hadn't been released yet.

### How can you get started?

Do you think this fits your product? Do you want to try it out on an MVP? Or do you just want to see what all this is about?

At [rootstrap](https://www.rootstrap.com/) we make your life easier by putting Hotwire all together with Tailwind, Devise, ActiveAdmin, and a couple more custom options. 

Go ahead and clone the [Ruby on Rails Hotwire Base](https://github.com/rootstrap/rails_hotwire_base) and start hacking! Also, don't forget to give us a :star: if you find it useful!
