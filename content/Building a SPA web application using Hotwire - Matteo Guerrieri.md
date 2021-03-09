## Building a SPA web application using Hotwire

In the past years, there has been a rise in Single Page Application ([SPA](https://en.wikipedia.org/wiki/Single-page_application)). Many of the modern web application tech stack relies on a JSON API in the backend and a frontend app modifying the DOM in the web browser, creating a fast and seamless experience.

When Ruby on Rails was created, it was created to render pages on the server, so to build a SPA with Ruby on Rails running on the backend meant rendering JSON payloads as a response and let the frontend take care of the rest.

But what if the frontend could update the DOM, sending HTML from the backend instead of JSON?

Here is where [Hotwire](https://hotwire.dev/) comes into action!

![Hotwire](images/hotwire.png)

From the Hotwire webpage:

> Hotwire is an alternative approach to building modern web applications without using much JavaScript by sending HTML instead of JSON over the wire. This makes for fast first-load pages, keeps template rendering on the server, and allows for a simpler, more productive development experience in any programming language, without sacrificing any of the speed or responsiveness associated with a traditional single-page application.

### Hotwire components

Hotwire consists of these three components:

- Turbo: This is the heart of Hotwire, it consists of a set of techniques for speeding up page changes and form submissions, dividing complex pages into components, and stream partial page updates over WebSocket, without writing any JS code at all.

- Stimulus: Some of the interactivity may need some JS code to work as wanted, so for that cases where custom code is required, Stimulus makes the work.

- Strada: This component is to allow mobile hybrid applications to talk to each other via HTML bridge attributes. At the moment of writing this article, Strada wasn't been released yet.

Do you think this fits your product? Do you want to try it on an MVP? Or do you just want to see what all this about?

At [rootstrap](https://www.rootstrap.com/) we made your life easier by putting Hotwire all together with Tailwind, Devise, ActiveAdmin and a couple more custom options. Go ahead and clone the [Ruby on Rails Hotwire Base](https://github.com/rootstrap/rails_hotwire_base) and start hacking!
