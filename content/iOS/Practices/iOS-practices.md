# A few iOS practices that can go a long way when maintaining your projects.

## Introduction 

Have you ever had to maintain or add features to a project you developed in the past and think: who wrote this and why do they hate me so much? 

I think this is quite normal since having in mind that some projects grow way bigger than we initially expected, and even when you have the best intentions, and you put lots of love and hard work in them, as you mature as a developer you start incorporating more and more practices, and the way you develop changes drastically, making it difficult and annoying to go back to older projects.

I wanted to write this article to help me and others avoid this feeling when retaking an old project.

The following are a few practices I've been incorporating and think it will help keep my next projects clean, easily maintainable, and extensible. 

## Project Structure

This may be one of the more obvious points for seasoned developers, but oh, how important it is!

As you develop your new project you may think this isn't that important, since you remember your file names and you can shift easily by searching them in Xcode.

However when some time passes this is no longer the case and finding the file you want to update may take you a while. 

### Organize code specific to your feature

In the root of the project, keep folders with each feature name, some examples we find in most projects are: Authentication, Profile, Home, Navigation, Networking, etc. 

Within these folders, group files tightly related to the feature in question. I like to divide them into different folders as follows: Models, Views, View Models, Managers, and Protocols. 

### Organize common code

In the root, besides the feature-specific folders I like to keep an Extension, Helpers, Common, and Resources folders.

In the Extension folder: keep extensions of the most used native controls and objects. 

In the Helpers folder: keep Constant files and classes you use regularly on the whole codebase. 

In Resources folder: keep any resource file your app will consume, these may be: Property lists, JSONs, Images, etc.

In Common folder: keep classes reused all along the codebase including: views, managers, protocols, as usual separated by type in different folders. 

So the next time I want to do an update, by a glance to the root I know the features my app implements and I can easily navigate to the file I want to update.  

### Files Structure

Within file classes keep related functions together in sections organized with Marks. Some examples for controllers are: View Lifecycle, Layout, User Interaction, Protocol Implementation, etc. 

It is also a nice practice to separate private functions into a private extension, so that a client at a glance at the class can differentiate the interface from the implementation.  

## Architecture Patterns

Be very mindful of the pattern you are gonna follow in your new project and stick with it! 

There's no right answer on what pattern to follow, it depends a lot on your project. I won't be enumerating every option as there are so many, and new ones keep being invented every day according to the new challenges we face as time passes, and we start seeing flaws in the existent ones.
So, let's stick to the more common ones for now. 

### MVC

Like many others, at first I started coding in MVC, one of the simpler ones. 
This pattern divides responsibilities into three class types: Models, Views, and Controllers. 
Models deals with data logic, Views display the UI and the Controllers handles communication between the two, navigation, and business logic.  

The problem with this pattern is that a lot of the responsibilities fall in the controllers' job, making them huge and ugly beasts that can be a real pain to maintain, test, and reuse in the future. 

### MVVM

This pattern divides responsibilities within Models, Views, and View Models, and is one of the most populars.
Business logic and communication between Models and Views are now responsibility of the ViewModel leaving the Controller responsibility to only handle user interaction, displaying the digested information the View Model provides in Views, and handling navigation. 

This extra separation of concerns allows us to keep a cleaner code base as well as facilitating unit testing.

There are a bunch of variations of this pattern, the most popular ones include a Coordinator that would handle navigation and flow of the app relieving view controllers from this work.  

For an example of this implementation you can check out [Rootstrap's iOS base](https://github.com/rootstrap/ios-base) a very helpful iOS project template to let you jump into your new project quickly. Check this [article](https://www.rootstrap.com/blog/2019/10/25/whats-great-about-our-ios-base/) to find out more about why we did that and how helpful it has been for us.  

## Resource Management 

As we mentioned before we want to have a folder in the root of the project for the resources our app will need, there are many types of resources so its helpful to organize them in different folders according to their type, for example, you may have: property lists, images, gifs, JSONs... and the list goes on.

For images, Xcode provides a very helpful resource bundle named xassets. 
Here we'll store the images our app uses, if your app has a fancy UI and uses loads of them is good to have them grouped in folders that describe their use. 

Images may be heavy, and we want our apps to be as small in size as possible, so if we find yourself having to add the same image in different colors its recommended to use them as templates and color them in code instead of adding different versions of the same image. 
Same goes for images with borders or different backgrounds, you'll save space by adding those decorations in code.  

Also, the naming of the resource itself should be descriptive enough so that you'll find it quickly and makes sense in the place you reference it. 

## Storyboards and xibs vs Code

Storyboards and xibs are great when you start learning to code in swift. 
The visual help does a lot kickstarting your designs and helping you understand `Auto Layout`.
Also if well handled, the way they represent the flow helps you understand a lot of the app by having a glance at it.

However... 
- They are heavy and often take a lot to load. 
- Connections between storyboard views and code are not checked in compiler time so you may have crashes if not careful.
- When working in a team the merge conflicts will be very hard to solve.
- It's very annoying to review the autogenerated code in Pull Requests.
- It doesn't favor reuse and componentization.

And most importantly there's not a "single source of truth" for your UI code. UI and navigation code will be divided between storyboards and your view controllers making it way harder to understand and maintain. 

So my inclination here is to do all UI work in code.
Once you understand how `Auto Layout` works, identify the code you are repeating, and develop helpers to avoid that, you'll find yourself accomplishing results faster, and with fewer lines of code. 
Code review processes will go much smoother, you'll find much more opportunities to reuse, and you'll find all UI work in a single place and avoid jumping from storyboards or xibs to code every minute.

If you loved the way you were able to quickly grasp your app's flow in the storyboard my recommendation would be to include flow diagrams in the code base, which may save precious time in the future!  

## Third-party Library Usage

Adding a third-party dependency to your codebase should be a conscious decision.
Some of them may help solve problems fast at first, but you may find yourself stuck when maintaining, either for lack of customizability or because it breaks with a new OS update. Also, they all have a learning curve, so other collaborators may have a hard time understanding how they work. 

When you find yourself integrating a third-party library, make sure you encapsulate it by defining a protocol and developing an implementation of it by calling the third-party library APIs. 
That way your code won't be tangled with it, and when you need to update, replace for another library, or by your own implementation you'll only need to touch a single file. 


I hope these practices are so helpful to you as they are to me. 
Please share your thoughts and let me know in the comments if you would like to know more about some of these topics or about the ones that were left out.
