
<img src="images/productivity-chart.jpg" alt="Working on foundations to increase productivity" width="400"/>

# What's good about our iOS-base

At Rootstrap, we develop custom made software for our clients, and as any other service, we are always trying to deliver the best quality product. Some of these products are native iOS applications, which is where one of our great teams starts to shine. In this article, I will be talking about our [iOS-base repository](https://github.com/rootstrap/ios-base), how it improved our team collaboration and rocket-launched development times and productivity.
#

## The problem

A few years ago, every time we started coding a new app, we found ourselves in a very repetitive task. Creating the same base project structure, copy-pasting code from previous projects, even re-implementing entire features, over and over. Thankfully, we identified that problem quickly and in a very short period we implemented our own version of a boilerplate project.


## The beginnings

The idea was simple, we wanted an XCode project that allowed us to jump right into feature development, maybe with slight modifications or architecture changes. We started putting together everything we knew we were using in every new app, including a networking layer, a couple of handy dependencies, view customization helpers, and a bunch of useful Swift extension. We even added example features for log-in and sign up users into the app and with local session storage.
That was it, not very ambitious but it saved a lot of setup time and of course, we now had something to collaborate and improve over time.

### No attachments

The project includes basic modules like session storage, routing, analytics and comes with MVVM architecture out of the box, but there is nothing that forces the developers to use this pattern or any other aspect of the main project.
As an engineer, you need to chose the right architecture for your application and our iOS-base allows you to do that with no hassle.

### Code quality

One of the implicit goals of this project was to centralize code quality standards for all iOS developers, and directly contribute to our company goals.

As a team, we reached an agreement on the requirements for a good code quality/best practices and made that a pillar in our code base. As a result we decided to:

  -   Adopted [Google’s swift style guides](https://github.com/google/swift).
  -   Configured [SwiftLint](https://github.com/realm/SwiftLint) to run locally and in the CI platform of preference. SwiftLint rules respond to our agreement and the style guide.
  -   Integrated CodeClimate to ensure the best coding practices.


## Things changed... for good

I would be sceptical if someone said that just by starting a new project from a boilderplate, it improved the productivity by a magical percentage.
The truth is that it really improved, not just productivity, but other aspects of our engineering team.
- The intial iterations finished earlier, generating confidence in our clients.
- The iOS-base plus a good shared-knowlegde base in our company, helped to develop similar features in record time.
- As an open source project it generated interest in the iOS team members and increased their willingness to collaborate.
- The project gave more visibility to our company from the tech point of view.
#

# Take away

Most people will ask, why creating _another_ iOS boilerplate project?
Yes, there are a few thousand open source projects out there with similar purposes. Some of them with more functionalities, some more specific, you name it.
The answer to that is that you will never find the one that solves all of your problems.

Of course you can fork the 'best match' and adapt it to your needs, but you will be missing the opportunity to make that **your own** solution.

### Key points if you decide to build your own:
- **Open source it!**
  : You will get/give help to/from other contributors.
  : A project of your authorship give people an insight of your work and how things are done in your company.
- **Pet it**
  : Continuous improvements, updates and maintainance are important.
  This also says a lot, a 2 years old last commit on a project is not a good sign.
- **Professionalize its maintainance**
  : We found very useful to create a GitHub project for the repository(a Trello board or similar will do the job as well).
  Managing milestones, new features implementation, issues, etc will be more organized, specially when working with teams.
  : Task assignment and bench management will benefit from these also.
#

In fewer words, build something that respond to your needs, then generalize it.

Would like to know the technical details of the project?
Check out the README at [iOS-base repository](https://github.com/rootstrap/ios-base)
