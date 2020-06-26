# How to make your app accessible using Voice Over

![](https://github.com/rootstrap/blog/blob/voice-over/content/images/glasses.jpg)

In a world where everything is relying more and more on technology, more tools are being provided for us developers to make our apps more accessible to everyone. Having limited sight should not be an impediment to use any app. As developers or designers, we need to raise awareness of all of those we're leaving behind and take a little time to make sure that our apps are accessible to everyone. Everyone wins, you'll broaden your market and increase your exposure, which will always lead to a positive impact on your profits. And the most important, by including people with disabilities you'll make a huge difference in their lives!

So, what makes an app accessible? According to the [Web Accessible Initiative](https://www.w3.org/WAI/fundamentals/accessibility-intro/), it means that the app has been designed so that people with disabilities are capable of using it, meaning they can not only perceive and understand it but also navigate and interact with the app. With that said, how can we make our apps accessible? There is a broad set of tools to help users with disabilities, we need to take action and remove the accessibility barriers by providing alternative solutions with the help of these tools. Specifically, in this article we'll talk about how to use, test, and improve accessibility using Voice Over.

### What is Voice Over?

For users that have a very low or no sight, there's Voice Over, a gesture-based screen reader that allows users to know what's on the screen by playing audible descriptions. The user can navigate through the screen by swiping and they can trigger different actions depending on a given [set of gestures](https://support.apple.com/guide/iphone/learn-Voice Over-gestures-iph3e2e2281/13.0/ios/13.0).

### Try it on one of your apps!

Open one of the apps you've developed and turn on Voice Over, read the entire content of the screen by swiping up using two fingers and voila, by default Voice Over will read some things, so that's a good head start, some buttons can be tapped by using double tap and some labels may be read correctly, but I can guarantee you that if accessibility was not taken into account in the design and development stages, then there will be issues. There might be things that are not being read in the correct order, things that are not being read at all, and some elements might not be grouped correctly because of a wrong view hierarchy. Some common mistakes can be that an uppercase text is by default read one letter at a time (OMG, for instance, should be read Oh my god, but instead the 3 letters will be read), and in case you have checkboxes probably the state of the checkbox is not being announced. If your app has those issues, users with disabilities won't be able to use it, because those things make it impossible for them to move forward.

### Get your hands dirty

One fun little experiment we did at Rootstrap was developing a very silly app. The purpose of it was to create to-do lists, users could add items that consisted of just a checkbox and a text and they could mark them as either complete or incomplete by checking on the checkbox, classic to-do stuff. We handed a blindfold to our CTO and asked him to add one item and mark it as complete, it was painful to watch, he struggled for a while to figure out how to open the keyboard. Then, we improved the default implementation a little:

- Gave our UI an intuitive hierarchy structure: Group UI elements that make sense together to provide a faster and better navigation

- isAccessibleElement: Make non relevant UI elements not focusable by Voice Over, like shadows and images, anything that's decorative

- accessibilityLabel: Provide a useful description to Voice Over to read when the item is focused

- accessibilityHint: Provide additional context or actions for the selected element

- accessibilityTraits: Tells Voice Over how the elements behave or should be treated, this can be button, isSelected, text, etc

- UIAccessibilityLayoutChangedNotification: Notifies Voice Over about changes in layout, so that the last item added to the list gets focused


These improvements that didn't take long to develop made a huge difference in UX, and we were able to prove it with our guinea pig who completed his mission successfully.

![](https://github.com/rootstrap/blog/blob/voice-over/content/images/blindfold.jpg)

### Debug it

The Accessibility Inspector belongs to the deck of developer tools, and one of the most powerful features provided by this tool is the ability to simulate VoiceOver, this was introduced in [xCode11](https://developer.apple.com/videos/play/wwdc2019/257/#:~:text=Menu%20Close%20Menu-,Accessibility%20Inspector,Voice%20Over%20user%20would%20experience.). And it's fantastic. You can simulate Voice Over thanks to a feature that was added recently by tapping on the speaker button. The auto-navigate button will navigate through all accessible views and read them for you so that you can debug it. A basic example that will provide a poor experience for users is when there’s a custom button with an image and VoiceOver will read the image file name, because no accessibility label was provided.

What's more, it does not only help you to detect issues with Voice Over, you can run an audit and it will throw any kind of accessibility issue. We invite you to try it on your own apps. It will detect more than you expect, potentially inaccessible text, contrast ratio, a button with a hit area too small, elements with no description, and unsupported dynamic fonts sizes.


### Other tools

Why stop there? Although Voice over is really useful for blind people, there are other types and degrees of visual impairment that not necessarily require the use of Voice Over and can have a much better experience if other accessibility adjustments are provided. To name a few: adjust the contrast, dynamic types, or even the color scheme for those who are color blind. A great range of new settings was introduced in iOS 14, you can check some of them on this [great WWDC2020 talk](https://developer.apple.com/videos/play/wwdc2020/10020/) that I invite you to watch

### Summary

Using an app with Voice Over can be a real challenge, and making an app accessible even tougher. Luckily for us, iOS provides useful and powerful tools to make our job easier. But at the end of the day, it is up to us to make use of their potential to the fullest.

By implementing just a few changes on our code and UI we can make a huge impact on blind and visually impaired users. As developers and designers, together we should become more conscious, think about all our possible users and make it easier for everyone. Excluding people from the content we create is self sabotage.

### References

[1] Apple Accessibility Guidelines - https://developer.apple.com/design/human-interface-guidelines/accessibility/overview/introduction/

[2] Make your app accessible - https://developer.apple.com/videos/play/wwdc2020/10020/

[3] Accessibility Inspector - https://developer.apple.com/videos/play/wwdc2019/257/#:~:text=Menu%20Close%20Menu-,Accessibility%20Inspector,Voice%20Over%20user%20would%20experience.
 
 
