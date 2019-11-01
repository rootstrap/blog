
<img src="images/productivity-chart.jpg" alt="Working on foundations to increase productivity" width="400"/>

# What's great about our iOS-base
**Abstract:** A prebuilt boilerplate code base can save time and effort when you create new projects. This article explains why a custom-built iOS base like ours works even better.

**Summary:** When you build a platform from scratch, some of the initial work might be the same for every project. You can save time by using one of many open-source code bases, or you can make your own. This article talks about the advantages of creating your own custom base.

At Rootstrap, we develop custom-made software for our clients. Like any other service, we always want to deliver the best quality product. Some of these products are native iOS applications. And that’s where our fantastic iOS design teams shines. In this article, I talk about our [iOS-base repository](https://github.com/rootstrap/ios-base) and how it improved our team collaboration and rocket-launched development times and productivity.

## The problem: repetitive work

A few years ago, we noticed that whenever we coded a new app, the work was extremely repetitive. Over and over, we created the same base project structure, copy-pasted code from previous projects, and even reimplemented entire features. But thankfully, we identified that problem quickly. In a short time, we implemented our own version of a boilerplate project.

## The first solution

Our idea was simple, we wanted an XCode project that allowed us to jump right into feature development, perhaps with slight modifications or architecture changes. First, we put together everything that we needed in every new app. Those elements included a networking layer, a few handy dependencies, view customization helpers, and some useful Swift extensions. We even added example features for users to sign up and sign in to the app with local session storage.
That project was it. It wasn’t very ambitious, but it saved a lot of setup time. And now, we had something to collaborate on and improve over time.

### No attachments

The Rootstrap iOS project includes basic modules like session storage, routing, and analytics. It also comes with MVVM architecture, but nothing forces developers to use that pattern or any other aspect of the main project.
As an engineer, you need to choose the right architecture for your application. Our iOS-base gives you a hassle-free way to do that.

### Code quality

One implicit goal was to centralize code quality standards for all iOS developers. At the same time, we wanted the project to contribute directly to our company goals.

As a team, we reached an agreement on the requirements for good code quality and best practices. We made those standards the pillar of our code base. From there, we decided to take these actions:

- Adopt [Google’s Swift style guides](https://github.com/google/swift).
- Configure [SwiftLint](https://github.com/realm/SwiftLint) to run locally and in the continuous integration (CI) platform of preference. SwiftLint rules respond to our agreement and the style guide.
- Integrate [Code Climate](https://codeclimate.com/) to ensure best coding practices.

## Things changed ... for the better

If someone claimed that just by starting a new project from a boilerplate, their productivity improved by a magical percentage, I’d be skeptical. But the truth is that our boilerplate didn’t just improve productivity. It also improved many other aspects of our engineering team’s work:
- Initial iterations were done faster, which grew client confidence.
- Adding the iOS base to our company’s shared knowledge base helped us develop similar features in record time.
- As an open source project, it generated interest in our iOS team members and increased their willingness to collaborate.
- The project increased company’s visibility in the tech community.

## Takeaways

You might ask “Why create another iOS boilerplate project when there are thousands of open source projects that do the same thing?” Some projects have more functionalities, and some are more specific. Despite their endless variations, you’ll never find one that solves all your specific and unique problems. Sure, you can fork the best match and adapt it to your needs. But you’ll miss a great opportunity to make the solution your own.

## Key points for building your own base
These are some recommendations based on our experience:
- **Open source it**
  : You can get and give help to or from other contributors.
  : The projects you open source showcase examples of your work and how things are done in your company.
- **Pet it**.
  : Continuous improvements, updates, and maintenance are important. For example, it doesn’t look good if you last committed to your project two years ago or it’s got build errors.
- **Professionalize maintenance**
  : Create a GitHub project, a Trello board, or something similar for your repository. Professional maintenance organizes your managed milestones, new feature implementation, issues, and other project elements. Collaborative team projects, task assignments, and bench management also benefit when everything is maintained in one place.
- **Keep it lean**.
  : Every project has different needs. Avoid adding features that tie you to a specific implementation or service.

In other words, build something that respond to your needs, then generalize it.

## Learn more
If you’re interested in the technical details of this project, check out the README at [iOS-base repository](https://github.com/rootstrap/ios-base).
