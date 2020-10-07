# Accessibility in React: Tools and Best Practices

![Main image](images/accessibility.jpg)

Accessibility should be standard when developing an application, but it’s sometimes forgotten. In this article, we will review some of the best tools and libraries. We will also share some of the best practices to broaden your reach and make your app accessible to all.   

## Why is accessibility important?

Internet nowadays is an essential part of our life for socializing, learning, getting a job, commerce, getting access to government services and health care services, and much more.

Making the apps accessible is incredibly important and not taking the time to do so affects roughly about ([61 million people in the USA](https://www.cdc.gov/ncbddd/disabilityandhealth/infographic-disability-impacts-all.html)) There's a huge problem with this as only [30% percent](https://www.huffingtonpost.co.uk/damiano-la-rocca/website-accessibility_b_9931304.html?guccounter=1&guce_referrer=aHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS8&guce_referrer_sig=AQAAAJobBHy6SubR-65wvVQ3zedOfXuRMmNGMJTpfWR5uVL2FjlWqI6aE9I_a6ewpFB8iI61U7RcYmJ3fYQbGulqkwmRAQNOBUfHhmGfBddbf5k209MMFPvS85Aae4HQLyNocKwZRKw6RWceAuLO5ZF1urVMNX0csJ4rS6TcD9wYA-0d) of the pages in the UK are abiding the accessibility law established, and in the USA the number and cost of federal accessibility lawsuits related to technological accessibility have risen dramatically over the last few years (the case that took more notoriety is the [Domino Pizza lawsuit](https://equidox.co/blog/robles-vs-dominos-pizza-explained-no-published-guidelines-doesnt-mean-no-standards/) by a blind user who could not use Domino's mobile app)

Therefore, **making a website accessible for everyone benefits not only individuals with disabilities but also businesses and society in general**.

## Who is everyone?

Contemplating on who the possible users are when developing an application is always difficult. We tend to simplify the user cases and focus on generating more features, and in some cases, we neglect the fact that some of our users may not be able to access those features.

The first thing we need to know to tackle this problem is the different kinds of disabilities there are:

- Auditory

- Cognitive

- Neurological

- Physical

- Speech

- Visual

Making your application accessible to everyone benefits those without disabilities, for example:

- People who have small cellphone screens. 

- People using slow internet connection

- And many more cases that we didn't know!

After reading this you're probably thinking that it's impossible to address all these kinds of disabilities through features. And that's true, it's impossible to create the perfect feature for everyone (in general, not only regarding accessibility), but it's totally possible to create features in which the majority of the users can access it, by simply by applying a few practices and tools.

## Introducing accessibility to your React application

There are lots of tools available and ready to be implemented in projects. Implementation can only require having to make little changes in everyday development practices. In this section, there's an introduction to some of the tools and classic mistakes that React developers make that can affect the accessibility of your application.

### Fragments and the wrapper hell

One of the classical mistakes that React developers usually make is to put a wrapper div in every component we create, for example:

https://gist.github.com/nsantos16/8da556d82904423cab8e812a921d68fa

This simple List component generates a div for each element, so when rendering the `ListComponent` it looks like this:

https://gist.github.com/nsantos16/1c3159e118a2d8af754d2a57b5e732dd

This makes the DOM confusing for visual interpretations programs that are used by people with visual disabilities.

A solution for this is using the API that React provides, `</Fragment>`, let's see:

https://gist.github.com/nsantos16/c097d8e791ad91ff45b0f835f5ab0219

which renders this:

https://gist.github.com/nsantos16/eae10c9f74bcc8ccec3357165fa1b584

### Put a title to every page

Add a title to all the pages of your application allowing users to recognize what is the content of the page and if it is relevant for them. Overall, people with visual, auditory, severe mobility and short-term memory disabilities benefit from it.

Furthermore, in React the use of **hooks** makes this an easy job:

https://gist.github.com/nsantos16/d42e2c264971373834c3718be90995a4

https://gist.github.com/nsantos16/02cee7facd1f13004c38c4def1deac46

### Accessibility auditing with react-axe

Integrate tools on the development process like linters, code formatters, pre-commit hooks, and other things that ensure code-quality and allow an agile implementation.

[`react-axe`](<[https://github.com/dequelabs/react-axe](https://github.com/dequelabs/react-axe)>) is one of them, this linter/analyzer will improve the process of supporting accessibility in your application in a fast way.

In its latest version, this tool both analyzes statically and in run-time your application. Meaning that, for example, the gradient of a screen is not sufficient for people with visual disabilities, the linter will throw a warning when you are running your application.

To integrate this tool, first, you need to add it as a dev dependency to your project

```console
yarn add react-axe --dev
```

then, you have to initialize it

https://gist.github.com/nsantos16/ff2d9eb40be4541ba9af577c0dd70e6f

And done! You have an accessibility linter integrated into your project.

### Buttons!

Buttons are a complex part of accessibility, the best way to improve buttons for accessibility is for your design team to involve practices in the development process.

Here in [Rootstrap](https://www.rootstrap.com/) we have guidelines about accessibility, you can check them out [here](https://www.figma.com/file/BsH7BBDNKPBQnaKdunKtJg/RS-UI-Global-Template)!

#### States

![Button states](https://i.ibb.co/N7Cxy7K/Captura-de-Pantalla-2020-07-24-a-la-s-17-59-19.png)

The state of buttons in React is very important. Three states are essential for correct behavior on accessibility, these are:

- **Focus**: When our user puts the target on a button, it's necessary to give the feedback through the color of the border, this allows users with visual disabilities to have a reference.

- **Textual label**: This, with focus events, is very important for interpreter programs, overall for visual and neurological disabilities. Also, it's very useful for people who don't understand what the button means and does.

- **Hover**: Change the shape of the button when the hover event happens to indicate in a quick way how button works.

#### Touch target

![enter image description here](https://i.ibb.co/fQB6NhR/Captura-de-Pantalla-2020-07-24-a-la-s-18-09-01.png)

People with low vision or with any kind of motor impairment may struggle to aim for the target, so every actionable element should have a touch target of 48 x 48 px. as a minimum.

#### Naming icons

![enter image description here](https://i.ibb.co/fH7Gtmy/Captura-de-Pantalla-2020-07-24-a-la-s-18-11-13.png)

People with vision impairments listening to screen readers will need an actionable copy to understand the interaction that every icon represents.

There are a few do/don't points we need to follow:

Do:

- Use infinitive verbs to indicate an action.

- Clarifying the object of the action (Create Account, See More Articles, Download Guide) or details that are critical, such as the price of a purchase.

Don't:

- Avoid ambiguous labels that don’t specify the action that has to be performed by the user.

- Use more words than necessary or try to convey urgency through the button’s copy.

## Lighthouse

[Lighthouse](https://developers.google.com/web/tools/lighthouse) is an audit tool for performance, accessibility, progressive web apps, SEO, and more that integrates as a developer tool in Chrome browsers.

With this simple tool and without any installation or setup, we can know where and which are the main aspects of our application to improve accessibility.
![enter image description here](https://developers.google.com/web/tools/lighthouse/images/cdt-report.png)

## Conclusion

Accessibility is a problem in the development industry. The industry does not understand the opportunity available to increase the quality of our products and make apps more inclusive for everyone. With simple tools and better practices - we can start to serve our users more adequately and acknowledge their unique needs. 
