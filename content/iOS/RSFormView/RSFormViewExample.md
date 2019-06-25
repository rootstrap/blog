# Build an app with RSFormView in Swift
*[Germán Stábile](https://www.rootstrap.com/tech-blog/) is an iOS developer on the Rootstrap team and recently has started to write about some of the challenges faced during iOS development. You can also follow Germán on [LinkedIn](https://www.linkedin.com/in/german-stabile-61a1b755/).*

Note: this post is meant to help you integrate RSFormView in your app, if you are interested in the motivation and implementation of RSFormView please take a look at the previous article [Link to previous article].

## Creating the project   

 During this article, we will be implementing a single view iOS application with RSFormView, step-by-step.
 
 Create a new Xcode project and select Single View Application. 
 Select a name and a destination for the project, in our case it'll be RSFormViewExample.

In order to integrate RSFormView we need Cocoapods, so we should install cocoapods and add a podfile in our project.
You can find instructions on how to do this in cocoapods [guides](https://guides.cocoapods.org/using/using-cocoapods.html).
Add this line in your podfile `pod RSFormView`, this will bring the last RSFormView available version whenever you run `pod install/update`.
Now that you have RSFormView installed you should see a workspace in your project folder, open it. 

## Creating your first view controller

Xcode will create a `Main.storyboard` by default, and a `ViewController.swift` class. 
Since we are gonna be doing the integration programmatically (you can find instructions to integrate RSFormView in a storyboard based application in the [README](https://github.com/rootstrap/RSFormView))
let's remove `Main.storyboard` and under Deployment Info in your target General tab, add "LaunchScreen" as Main Interface.

![Alt](images/targetSettings.png)

Now let's rename `ViewController.swift` to something more descriptive, perhaps: `FormViewExampleViewController.swift` 
and write `application(didFinishLaunchingWithOptions:)` in our `AppDelegate.swift`:

``` swift
  let navigationController = UINavigationController(rootViewController: FormViewExampleViewController())
  navigationController.setNavigationBarHidden(true, animated: false)
  window?.rootViewController = navigationController
  return true
```
Here we are setting a `UINavigationController` with our initial view controller as root, hiding the navigation var and setting it to be our
`window`'s `rootViewController`.

If you run your app now it will display a white screen, so let's add some content to the view controller. 

## Managing your ViewController's layout  

First, let's import `RSFormView` in order to get access to the module: add `import RSFormView` at the top of the file. 

Then let's add properties for our UI components.

``` swift
//MARK: UIComponents
var formView = FormView()
var submitButton = UIButton(type: .custom)
var descriptionLabel = UILabel()
var switchLabel = UILabel()
var modeSwitch = UISwitch()
```

You may be wondering what are all these UI components for?

We are gonna be building a view controller with a description label on top, below we'll set a label  with an UISwitch next to it,
to enable/disable a fancy "dark mode". Our FormView will sit right below the label and UISwitch and our bottom view will be our submitButton.

Our view controller will look something like this:

![Alt](images/viewControllerDiagram.png)

So let's start coding: 

First, we will override `viewDidLoad`, call super as we always should and then call `configureViews` were we're gonna be doing the actual layout.

`configureViews` will look like this:

``` swift
func configureViews() {
  view.backgroundColor = UIColor.white
  configureFormView()
  configureLabels()
  configureSubmitButton()
  configureSwitch()
  configureConstraints()
}
```

This function is responsible of configuring every UIComponent in this view controller so in order to make it readable we are breaking it in different functions. 
The naming should be self-explanatory here, and each configure function should be pretty straight forward except for  `configureConstraints` were all the autolayout magic is gonna happen.

``` swift
func configureSubmitButton() {
  updateSubmitButton(enabled: false)
  submitButton.layer.cornerRadius = 8
  submitButton.setTitle("SUBMIT", for: .normal)
  submitButton.setTitleColor(UIColor.white, for: .normal)
  submitButton.translatesAutoresizingMaskIntoConstraints = false
  submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

  view.addSubview(submitButton)
}

func configureLabels() {
  descriptionLabel.numberOfLines = 0
  descriptionLabel.lineBreakMode = .byWordWrapping
  descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
  descriptionLabel.textColor = UIColor.brightGray
  descriptionLabel.textAlignment = .center
  descriptionLabel.text = "This is an example of a RSFormView changing its aspect on an user triggered event"
  descriptionLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)

  view.addSubview(descriptionLabel)

  switchLabel.textColor = UIColor.brightGray
  switchLabel.textAlignment = .left
  switchLabel.translatesAutoresizingMaskIntoConstraints = false
  switchLabel.text = "Enable dark mode"
  switchLabel.font = UIFont.systemFont(ofSize: 19)

  view.addSubview(switchLabel)
}

func configureSwitch() {
  modeSwitch.isOn = false
  modeSwitch.onTintColor = UIColor.dodgerBlue
  modeSwitch.translatesAutoresizingMaskIntoConstraints = false
  modeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)

  view.addSubview(modeSwitch)
}
```

In each of these functions we are setting the initial state for each UI Component (except the formView, we are leaving that for the end).
We are setting titles to labels and buttons, as well as background colors. 
We are setting actions for the submit button and the `modeSwitch` and setting `translatesAutoresizingMaskIntoConstraints`  to false to every UIComponent, since we are relying on autolayout to place the views.
Finally we are adding the views to our viewController's view. 
You are going to be seeing compiler errors when setting submitButton and modeSwitch targets since the referenced selectors are not defined yet, ignore those for now. 

Now let's configure the formView: 

``` swift
func configureFormView() {
  formView.delegate = self
  formView.viewModel = formHelper
  formView.translatesAutoresizingMaskIntoConstraints = false

  view.addSubview(formView)
}
```

You should be seeing two compiler errors in this function. 
This is because your view controller doesn't comply to `FormViewModel` delegate and  `formHelper` was never defined. 
We are gonna see how to do this in the next section. 

Now let's tackle  `configureConstraints`, responsible of setting all the layout rules for every view in our view controller.

``` swift
func configureConstraints() {
  let horizontalMargins: CGFloat = 32
  let verticalMargins: CGFloat = 10
  let submitButtonMargins: CGFloat = 24

  NSLayoutConstraint.activate([
    descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalMargins * 3),
    descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
    descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins),
    descriptionLabel.bottomAnchor.constraint(equalTo: switchLabel.topAnchor, constant: -verticalMargins * 4),

    switchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargins),
    switchLabel.trailingAnchor.constraint(equalTo: modeSwitch.leadingAnchor, constant: horizontalMargins),
    switchLabel.bottomAnchor.constraint(equalTo: formView.topAnchor, constant: -verticalMargins),

    modeSwitch.widthAnchor.constraint(equalToConstant: 49),
    modeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargins),
    modeSwitch.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor),

    formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    formView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -verticalMargins),

    submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: submitButtonMargins),
    submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -submitButtonMargins),
    submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -submitButtonMargins),
    submitButton.heightAnchor.constraint(equalToConstant: 44)
])
}
```

Here we are setting constraints to attach views with each other in order to accomplish the design we had in mind. 


## Populating your FormView

Let's start by implementing the  `FormViewModel` delegate: 
I tend to prefer implementing delegates in an extension of the implementing class to keep concerns separated, so let's do that. 
Outside of the `FormViewExampleViewController` class scope we do:

``` swift
extension FormViewExampleViewController: FormViewDelegate {
  func didUpdateFields(in formView: FormView, allFieldsValid: Bool) {
    updateSubmitButton(enabled: allFieldsValid)
  }
}
```

This delegate method is gonna be called every time the user types, or select a new value in pickers and will let us know if all the fields are complete and the values are valid.
So we are gonna update the submit button accordingly, this is the function to do so: 

``` swift 
func updateSubmitButton(enabled: Bool) {
  let backgroundColor = enabled ? UIColor.dodgerBlue : UIColor.brightGray.withAlphaComponent(0.4)
  submitButton.backgroundColor = backgroundColor
  submitButton.isUserInteractionEnabled = enabled
}
```

When we set a FormView `viewModel` we are telling the formView this is the object that's gonna be populating it.
This object needs to conform to `FormViewModel` protocol in order to do so. 
This protocol only requires that you hold an items array of `FormItem`s.
Let's create a file to implement the FormViewModel, let's use ExampleFormHelper as a name. 
To keep this short I'm gonna be only showing how to add a couple of items. Take a look at the implementation: 

``` swift
import RSFormView

class ExampleFormHelper: FormViewModel {

var items: [FormItem] = []

lazy var nameItem: FormItem = {
  let firstNameField = FormField(name: "FIRST NAME",
                                 initialValue: "",
                                 placeholder: "FIRST NAME",
                                 fieldType: .regular,
                                 isValid: false,
                                 errorMessage: "First name can't be empty")
  let lastNameField = FormField(name: "LAST NAME",
                                initialValue: "",
                                placeholder: "LAST NAME",
                                fieldType: .regular,
                                isValid: false,
                                errorMessage: "Last name can't be empty")

  return TwoTextFieldCellItem(firstField: firstNameField, secondField: lastNameField)
}()

lazy var personalInfoHeaderItem: FormItem = {
  let headerItem = TextCellItem()
  headerItem.attributedText = NSAttributedString(string: "Enter your personal info",
                                                 attributes: [.foregroundColor: UIColor.brightGray,
                                                              .font: UIFont.systemFont(ofSize: 20)])
  return headerItem
}()

func init() {
  items = [nameItem, personalInfoHeaderItem]
}
```

Here we are only adding two items, to see the whole implementation you can download the example project I'm attaching at the end of this article.  
Since we are setting two FormFields in the first item it will be rendered as a cell with two text fields. 
For the header, we are only setting a `NSAttributedString` so it will be rendered as a single label cell with the appearance we set in the attributes. 

Now we go back to our FormExampleViewController and we define a var to hold our form helper. 

``` swift 
var formHelper = ExampleFormHelper()
```

Finally, we define actions for the submitButton and modeSwitch: 

``` swift
//MASK: Actions
@objc
func switchValueChanged(sender: UISwitch) {
  let isDarkMode = sender.isOn
  let configurator = isDarkMode ? DarkModeConfigurator() : FormConfigurator()
  formHelper.updateHeaders(isDarkMode: isDarkMode)
  formView.formConfigurator = configurator
  view.backgroundColor = isDarkMode ? UIColor.mineShaftGray : UIColor.white
  descriptionLabel.textColor = isDarkMode ? UIColor.white : UIColor.brightGray
  switchLabel.textColor = isDarkMode ? UIColor.white : UIColor.brightGray
}

@objc
func submitButtonTapped() {
  var collectedData = ""
  for field in formHelper.fields() {
    collectedData += "\(field.name): \(field.value) \n"
  }
  let alert = UIAlertController(title: "Collected data",
                                message: collectedData,
                                preferredStyle: .alert)
  alert.addAction(UIAlertAction(title: "OK",
                                style: .cancel))
  present(alert, animated: true)
}
```
`switchValueChanged` changes our views aspect according to the selected value, if set to on we go for a "dark mode" otherwise we go for a clear mode. 
Here we are using the two out of the box configurations for the formView the `DarkModeConfigurator` and the default `FormConfigurator`

In the submit button action we are iterating through all the fields in the formView and displaying them in an alert along with the field names. 

Here is the result when switching between modes: 

![Alt](images/switchMode.gif)

And here what happens when you tap the submit button:

![Alt](images/submitTapped.gif)

You can clone the example app repo [here](https://github.com/rootstrap/RSFormViewExample)

Thanks for reading! 


