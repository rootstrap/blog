# How to Effectively Integrate a Typography System in React Native

![Main image](images/rn_typography_main.jpg)

## The Problem

If there is one thing that most react native apps have in common it is how they display text. Some simple apps show very little, but most apps display a lot. That is why it's vital to put the right system in place, to ensure adding and refactoring texts in your app is as simple as possible.

Now, you might be thinking - why am I reading an article on how to manage such a simple component? It's just text, right? Yes, but more often than not, you need to apply styles and properties to said text to make it look the way you want. When you have to do it for all the texts in your app, it adds up. It, of course, begs the question - how can I reduce the amount of code repetition?

Over the years, I have seen my fair share of attempts at solving this problem, and I can finally say that I have landed on one solution that left me quite pleased.

## The Solution

The solution is quite simple, but it's based on following best UI practices. What do I mean? Having predefined styles for headings, paragraphs, and other texts that you might need. What is important is that all the texts of your app fall into one of those definitions and that the amount doesn't get out of hand. It's good to keep the number of definitions short, so it's easier to remember what to put when coding and that your app is consistent in its respective styling, which in turn, gives you usability and accessibility points.

Without any further ado, here is the aforementioned code of the component and supplementary files:

https://gist.github.com/aguscha333/7de34fd9219213f1e5ff48db208d7d6e

Once you have all of that in place, you can simply import the component and use it as follows:

https://gist.github.com/aguscha333/11911e87d42a510a35461a6d927e0a83

It's as simple as that, and usually, you will only have to apply extra styles to a particular text component instance if you need to add spacing, color, or wrapping.

Taking the naming convention and hierarchy of text components from the web makes it very easy to understand and remember. As you may have noticed, with the use of prop-types, it is very easy to notice if you misspelled a type when setting it on an instance of said component.

Although adding custom fonts to your React Native project is out of scope for this article, you might find (link here) this article useful where we go over that subject ([How to customize fonts in React Native](https://www.rootstrap.com/blog/how-to-customize-fonts-in-react-native/))

## Conclusions

As you can see, the solution is very clean and simple, but it fixes a problem in a component that is so basic that it is also often overlooked. Putting a bit of time and thought into these kinds of components that make up the core DNA of our apps can go a long way.

I hope you find this article helpful and that you end up implementing this solution in your projects.
