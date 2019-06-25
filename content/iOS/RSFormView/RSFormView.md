# Quickly Implementing elegant forms with RSFormView in Swift
*[Germán Stábile](https://www.rootstrap.com/tech-blog/) is an iOS developer on the Rootstrap team and recently has started to write about some of the challenges faced during iOS development. You can also follow Germán on [LinkedIn](https://www.linkedin.com/in/german-stabile-61a1b755/).*

Note: this post is meant to discuss motivations and implementation of RSFormView, if you are interested in a tutorial on how to integrate please visit [RSFormView Readme](https://github.com/rootstrap/RSFormView) or the next article [Link to next article].

## Introduction 

During my first experience with React-Native for a short, form-based project, I discovered the extremely useful [redux-form](https://github.com/erikras/redux-form)  library and kept thinking on how nice would it be to have such library for iOS development. After finishing that project it was time to move back to iOS native programming for another project--yay!
A few glances at the beautiful wireframes the design team provided and I see at least five forms for data entry: and so I thought, developing a form component with such awesome design by default may be both useful and fun! 

As an iOS developer, I've seen and worked with a bunch of different form implementations. Some repeated too much code. And the ones with a more componentized solution were buggy, hard to extend, or impossible to accomplish the intended design.  

I wanted to avoid these issues and implement something we could use in different projects. But given the time constraints I knew I couldn't build something as configurable as [redux-form](https://github.com/erikras/redux-form).

However, with the beautiful design I was handed over, and making fonts, colors, and margins configurable,  we could put together a really helpful library. 
That we can always extend in the future. 

Development on that project was very smooth having implemented this component beforehand. I was able to finish any form based screen in a few minutes and with very few lines of code. I was so happy with the results that I wanted to use the extra time in my hands and share the goods with the open source community.    

## What Is RSFormView?

[RSFormView](https://github.com/rootstrap/RSFormView) is a library that allows you to create data entry forms in a few minutes with a modern look and feel based on [material design 2](https://material.io), that you can also configure setting your custom colors, fonts, and margins or even adding your own custom views. 

![Alt](images/formExample.gif)

### What can it do? 

- Supports different data entry options out-of-the-box: regular text fields, password text fields, date pickers, options pickers, etc.
- Provides default validation for each text field type. Default validation can be overridden with any of the available validation types or your custom validation.
- Allows easy configuration: you can choose if you want the formView to be scrollable or not and choose your own fonts, colors and margins for each text field state (editing, valid and invalid).
- The FormView makes a callback to its delegate whenever a change is made, so there you can update any view dependant on the data entered. (For example  enable/disable a submit button).
- You can easily collect the entered data by iterating the items array of your FormViewModel.
- Ability to manually mark items as invalid, useful when you have backend validation. 
- Ability to use TextFieldView (component inserted to FormViewCells) with no need of a FormView. 
- Dark mode configuration can be set with a single line of code.
- Ability to perform matching validation: useful for password/confirm password fields.
- Adding custom views to have your own look and feel.

### What needs to be improved? 

- Adding more out-of-the-box field types (we are planning to do this gradually as we identify more needs).
- Better support long error messages.
- Support [Carthage](https://github.com/Carthage/Carthage).
- Support [Swift Package Manager](https://swift.org/package-manager/).

## How is it implemented?

FormView is a custom view with a single UITableView embedded. 
The table view is populated with three out-of-the-box cells: `TextFieldCell`, `TwoTextFieldsCell`, `FormTextCell`. 

What type of cell is going to be displayed is determined by your implementation of the `FormViewModel` protocol. The protocol requires that you hold a `FormItem` array.

We provide some `FormItem` subclasses by default: `TextFieldCellItem`, `TwoTextFieldCellItem` and `TextCellItem`.
A `TextFieldCellItem` will be rendered as `TextFieldCell`.
`TwoTextFieldCellItem` will be rendered as a `TwoTextFieldsCell`. 
`TextCellItem` with an `NSAttributedString`  will be render as `FormTextCell` you can use as a header, beside the `NSAttributedString` attributes you can further customize it by setting a `ConstraintsConfigurator`. 

`TextFieldCells` hold a `TextFieldView` that is going to update its state according to the text entered and the validation you have set in the related `FormField`, validations will be done real-time (as the user types).
The delegate will be notified every time an entry is made, so you can update any dependant view as needed. 

To describe the validation, field type, placeholder, title and more of your text fields you set a `FormField` to your `TextFieldCellItems` .

See RSFormView Readme for usage examples and guidance: https://github.com/rootstrap/RSFormView.
In that repo, you'll also find an example app using RSFormView.
Feel free to leave your feedback and request improvements or additions by creating issues. 

If you're interested in a tutorial showcasing some of the functionalities continue reading: [Link to next article].

Thanks so much for reading! I hope you find the library useful! 





