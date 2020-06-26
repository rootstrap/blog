### Working with animations in React Native

![](https://github.com/rootstrap/blog/blob/fernandatoledo-RN-animations/content/images/animation.jpeg)

### The introduction

As mobile developers who have worked with animations before, we know how hard it can be to implement complex animations from scratch. That's why we decided to engineer a simple yet powerful React Native animation hooks library that can give you a head start when developing your animations. It will also help you understand how animations work at their core and break down more complex animations.

### Animated API

React Native provides us with an Animated API that allows us to animate several of their components. It does that by exposing a broad range of animation types and auxiliary functions. That being said it can be a bit daunting if you are trying to tackle your first animation. 

Our hook library uses this API under the hood but simplifies how animations are implemented by the developer.

#### The Basics

To understand how the Animated API works let's just show a basic example of `Animated.timing()`, which is the most commonly used animation type.
 
https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-animatedview-js


What we are doing here is creating a variable that will contain the value that we will be animating. We use `useRef` since the returned value will persist for the full lifetime of the component.
Then we take that variable and feed it to the `animated.timing()` method that transitions the initial value we set in the variable to the final value we provide in `toValue`.
By passing the current value of the ref variable to a style property of a given animated component, said component is re-rendered on a high priority thread, which will make your animations run smoothly.
Did you get lost already? The same happened to us, that's why we created our hook library.

### Our first animation hook

Given our experience, we've identified a repetitive pattern among React Native animations. Opacity, translations, rotations, size, scale, and background color transition. All of these animations share very similar code. That's why we started this project by creating a simple hook that is much easier to use in hopes that more developers would be willing to give animations a try. The hook covers the basics but you would be surprised how much value a simple animation can add.

Let's take a look at the first example we provided above but this time using the `useAnimate` hook:

https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-simpleanimationwithhook-js


As you can see with just a few simple lines you can have your opacity animation. With the same simplicity, you can start animating background colors, translations to get objects moving, rotations, and much more.

And in this case, we wanted to show the most basic example, but there are other options you can customize. The number of iterations, bounce (if you want your animation to return to its initial state), the easing function, a callback function and a delay before your animation starts.

#### How to handle more complex animations?

Although the `useAnimate` hook covers most transitions that you would want to do, there are some limitations to it. The `useAnimate` hook is most useful for atomic transitions and by that we mean that it is perfect for animating one thing at a time. If you want to run parallel animations or sequences, you might need to use some functionalities that the basic hook simply does not cover. For these cases, we have two extra hooks that can help.

This project started as just one basic animation hook. Later on, while developing a demo app for showcasing purposes, we started fiddling around with what the Animated API has to offer and we ended up creating two more hooks, one for running parallel animations and one for running them in sequence.

Here are examples of how using those hooks might look like versus their plain Animated API counterparts. 

##### Example of sequence animation

![](https://media.giphy.com/media/hQcYhmrFy7aXFReeR7/giphy.gif)

https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-sequencewithouthook-js

https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-sequencewithhook-js


In this example there are two animations taking place in sequence, a horizontal and a vertical translation, each happening one at a time, the following one starts right after the current animation is finished.

##### Example of parallel animation

![](https://media.giphy.com/media/QTxxds3ZqTedzYYFFr/giphy.gif)

https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-parallelwithouthook-js

https://gist.github.com/fernandatoledo/3a656f21eb16f01b0f963a7fec1fb09e#file-parallelwithhook-js

In this example multiple animations are taking place in parallel, there's a vertical and horizontal translation, along with rotation.

#### Our Library

In order to make our hooks readily available to any developer that wants to start their React Native animations journey, we created a library that contains the hooks described in this article. You can try it out by just running on your react native project folder:
```
yarn add @rootstrap/react-native-use-animate
```
Or
```
npm install @rootstrap/react-native-use-animate --save
```

#### Alternatives

While reading this post you might have asked yourself, are there any alternative libraries out there that do this? And the answer is yes. To name a few of the most well-known ones we have [react-native-reanimated](https://github.com/software-mansion/react-native-reanimated), [react-native-animatable](https://github.com/oblador/react-native-animatable), [react-native-motion](https://github.com/xotahal/react-native-motion), [Lottie](https://airbnb.io/lottie).

They all serve different purposes and depending on what you need to implement you might decide to go for one or the other. One thing that they all have in common is that they cover a lot of ground with their APIs and that is good. At the same time if you are just getting started and want to do a simple animation there are two drawbacks that we found. First, kind of the same issue we mentioned about React Native's own Animated API, there are too many options and a lot to read in order to get used to it which could be overwhelming. Second, these are rather big libraries, some bigger than others but overall, they all pack things that are not needed if you are just looking to lift up your application a bit by adding a simple animation here and there.

This is why we believe that our library has its own distinct purpose and can coexist with the other alternatives out there. As we mentioned before our library is ideal for people that are just getting started or want to implement simple animations.


### Summary

Getting started with animations in React Native can be a bit overwhelming so we created a library to simplify this process and make it more inviting for developers that might have been on the fence about adding animations to their apps.

We hope that the React Native community starts using this library and that we start getting feedback so we can continue to improve the library and provide a better experience for beginners.

Remember that to get started you can just simply add the library by using `npm` or `yarn`.

You can always check the source code [here](https://github.com/rootstrap/react-native-use-animate#readme) and contributions are always welcomed.

Please leave a comment, we would love to know your thoughts on this.


### References

[1] https://medium.com/react-native-training/react-native-animations-using-the-animated-api-ebe8e0669fae

[2] https://reactnative.dev/docs/animations

[3] https://medium.com/@benjamintodts/react-natives-animated-loop-invoking-a-callback-whenever-an-iteration-finishes-1c3581d38d54

[4] https://medium.com/@GroundControl/animating-gradients-in-react-native-8853dbd97d02

[5] https://blog.bitsrc.io/making-animations-in-react-native-the-simplified-guide-6580f961f6e8

[6] https://blog.bitsrc.io/top-5-animation-libraries-in-react-native-d00ec8ddfc8d
