## Introduction

Accessibility is one of the principal points when you develop an application (and one of those points that **developers tend to forget or not to knowing how to implment**). In this article, we will make a review of some of the tools, libraries, and standards that make it easier to integrate the best practices associated with accessibility on the web, making your application usable by many people as possible.

## Why is important the accessibility?

Internet nowadays is an essential part of our life for socializing, learning, get a job, commerce, getting access to government services as well as access to health care services, and much more.

The accessibility of the different platforms plays an important role here, and takes a lot of relevance for a lot of people ([61 million people only in USA](https://www.cdc.gov/ncbddd/disabilityandhealth/infographic-disability-impacts-all.html)), but there's a huge problem, only [the 30% percent](https://www.huffingtonpost.co.uk/damiano-la-rocca/website-accessibility_b_9931304.html?guccounter=1&guce_referrer=aHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS8&guce_referrer_sig=AQAAAJobBHy6SubR-65wvVQ3zedOfXuRMmNGMJTpfWR5uVL2FjlWqI6aE9I_a6ewpFB8iI61U7RcYmJ3fYQbGulqkwmRAQNOBUfHhmGfBddbf5k209MMFPvS85Aae4HQLyNocKwZRKw6RWceAuLO5ZF1urVMNX0csJ4rS6TcD9wYA-0d) of the pages in UK aren't breaking the law of accessibility established in that country, and in USA the number and cost of federal accessibility lawsuits related with technological accessibility has risen dramatically in the last few years (the case that took more notoriety is the [Domino Pizza demand](https://equidox.co/blog/robles-vs-dominos-pizza-explained-no-published-guidelines-doesnt-mean-no-standards/) by a blind user who could not use Domino's mobile app).

So, **make a website accessible for everyone benefits individuals, businesses, and society**.

## Who is everyone?

Contemplate which are the possible users when we develop an application is always difficult, we tend to simplify the user cases and focus on generating more features, and in some cases, we affect the value awarded to our users, among other things, because our users can't access to that features.

The first we need to know to tackle this problem is the different kinds of disabilities there are:

- Auditory

- Cognitive

- Neurological

- Physical

- Speech

- Visual

Also, make your application accessible for everyone benefits to the people without disabilities, for example:

- People who access with small screens cellphones

- People using slow internet connection

- And many more cases that we didn't know!

You probably think after read this, that is impossible contemplate these kinds of disabilities for all the features that you implement every day, And that's true, is impossible create the perfect feature for everyone (in general, not only with accessibility subject), but is totally possible create a feature that the majority of the users can access to it, applying only a some practices and tools.

## Introduce accessibility in your React application

We have a lot of tools and standards out there, ready to be used and implemented in our project with only change little aspects in the way we develop every day. So in this section, there's an introduction of some of the tools and classics mistakes that React developers does that affect the accessibility of your application.

### Fragments and the wrapper hell

One of the classical mistakes that the react developers we commit usually is put a wrapper div in every component we created, for example:

https://gist.github.com/nsantos16/8da556d82904423cab8e812a921d68fa

This simple List component generates a div for each element, so when it rendering the `ListComponent` looks like this:

https://gist.github.com/nsantos16/1c3159e118a2d8af754d2a57b5e732dd

this makes the dom confusing for visual interpretations programs that are used by people with visual disabilities.

A solution for this is using the API that React provides, more particularly, `</Fragment>`, let's see:

https://gist.github.com/nsantos16/c097d8e791ad91ff45b0f835f5ab0219

which rendering this:

https://gist.github.com/nsantos16/eae10c9f74bcc8ccec3357165fa1b584

### Put a title to every page

Add a title to all the pages of your application allowing users to recognize what is the content of the page and if it is relevant for them. Overall, people with visual, auditory, severe mobility and short-term memory disabilities benefit from it.

Furthermore, in React the use of **hooks** makes this an easy job:

https://gist.github.com/nsantos16/d42e2c264971373834c3718be90995a4

https://gist.github.com/nsantos16/02cee7facd1f13004c38c4def1deac46

### Accessibility auditing with react-axe

Integrate tools on the development process like linters, formatter codes, pre-commit hooks, and other things ensure code-quality and allow an agile implementation.

[`react-axe`](<[https://github.com/dequelabs/react-axe](https://github.com/dequelabs/react-axe)>) is one of them, this linter/analyzer it will improve the process of include accessibility in your application in a fast way.

This tool in his new version, apart of analyzing statically the code of your application, also _analyzes in run-time_, that means, if for example, the gradient of a screen is not sufficient for people with visual disabilities, the linter will throw a warning when you are running your application.

For integrate this tool, first, you need to add as a dev dependency in your project

```console
yarn add react-axe --dev
```

then, you have to initialize it

https://gist.github.com/nsantos16/ff2d9eb40be4541ba9af577c0dd70e6f

And done! You have an accessibility linter integrated into your project.

### Buttons!

Buttons are a complex part of the accessibility, the best way to improve buttons for accessibility is your design team involve practices in the development process.

Here in [Rootstrap](<[https://www.rootstrap.com/](https://www.rootstrap.com/)>) we have guidelines about accesibility, you can check [here](<[https://www.figma.com/file/BsH7BBDNKPBQnaKdunKtJg/RS-UI-Global-Template](https://www.figma.com/file/BsH7BBDNKPBQnaKdunKtJg/RS-UI-Global-Template)>)!

#### States

![Button states](https://i.ibb.co/N7Cxy7K/Captura-de-Pantalla-2020-07-24-a-la-s-17-59-19.png)

The states of the buttons in React are very important, three states are essential for correct behavior on accessibility, there are:

- **Focus**: When our user puts the target on a button, is necessary to give the feedback through the color of the border, this allows users with visual disabilities to have a reference.

- **Textual label**: This with focus events, is very important for interpreter programs, overall for visual and neurological disabilities. Also, is very useful for people who don't understand what means and do the button.

- **Hover**: Change the shape of the button when the hover event happens to indicate in a quick way how button works.

#### Touch target

![enter image description here](https://i.ibb.co/fQB6NhR/Captura-de-Pantalla-2020-07-24-a-la-s-18-09-01.png)

People with low vision or with any kind of motor impairment may struggle to aim for the target, so every actionable element should have a touch target of 48 x 48 px. as a minimum.

#### Naming icons

![enter image description here](https://i.ibb.co/fH7Gtmy/Captura-de-Pantalla-2020-07-24-a-la-s-18-11-13.png)

People with vision impairments listening to screen readers will need an actionable copy to understand the interaction that every icon represents.

There are a few do/don't points we need to follow:

Do:

- Naming an icon based on the action it will perform.

- Using infinitive verbs to indicate an action.

- Clarify the object of the action (Create Account, See More Articles, Download Guide) or details that are critical, such as the price of a purchase.

Don't:

- Naming an icon based on its morphology.

- Using infinitive verbs to indicate an action.

- Clarify the object of the action (Create Account, See More Articles, Download Guide) or details that are critical, such as the price of a purchase.

## Lighthouse

[Lighthouse](<[https://developers.google.com/web/tools/lighthouse](https://developers.google.com/web/tools/lighthouse)>) is an audit tool for performance, accessibility, progressive web apps, SEO, and more integrating as a developer tool the Chrome browsers.

With this simple tool and without any installation or setup, we can know where and which are the main aspects of our application to improves the accessibility.
![enter image description here](https://developers.google.com/web/tools/lighthouse/images/cdt-report.png)

## Conclusion

Accessibility is a big problem on the web right now, our industry does not perceive the decrease of the value on the products we build for the simple reason that a big part of the potential users can't access to the features we develop every day. With simple tools and practices, we can increase the quality of our products and make society more inclusive for everyone.
