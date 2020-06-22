## Google is a modal dialog

### The shame of being a modal dialog

A modal dialog is a window which pops up on top of every other window freezing the
underlaying user interface until the user dismisses it.

Its use was quite frequent in the early days of desktop windows apps but with the
beginning of browser user intefaces they not only became obsolete but some articles
were writen discouraging its use in favor of edit in place interfaces.

I'm no UX expert but I am a user of graphics user intefaces on a daily basis and
 as a user I will speak up in defense of modal dialogs when used properly.

### The importance of being modal

What do modal dialogs do?

When I first thought in modal dialogs I focused mainly on the space location
in the user interface.

The first desktop apps achieved 3D emulation by overlapping 2D rectangles called
windows [1].

Browser interfaces avoid 3D emulation and usually stick to a strict 2D interface
through laying out its elements instead of using overlapping.

However this is just the implementation of what modal dialogs do and not its functional
purpose and value.

Modal dialogs interrupt the flow of the user attention to solve a particular task
providing a self contained, highly focused functional and visual context for the user.

That is they provide for a very short period of time a user interface for the user
to solve a specific task hidding every other complexity not related to that task.

Once the user ends solving that specific part of the app it returns to the previous
flow just like she left it.

Whichs is pretty much the same workflow that we use to google things

### Google is a modal dialog

How do we google things?

Usually we are doing something like writing a blog post and we find the need to
search for information.

We open a new tab with a clean and very specific design to do just one thing,
search things.

We select a few results, decide whether our question was answered or not and get
back to our previous task closing the search tab.

That is what modal dialogs functional purpose is regardless of its implementation
on the user interface space.

### Other issues with edit in place

There are two very important functions in a modal dialog.

The first one would be the one already mentioned, to provide an isolated context
to solve a specific task hidding all other context not relevant to that task.

Yet there is another function just as important: hidding unnecessary complexity
in the main application interface until that complexity is required.

The rationale of a modal dialog is to present to the user the complexity of
a user interface when the user needs it, not before, not afterwards, and just for
the time the user is dealing with that task.

The proliferation of menu options and visual aids can hurt more than they would help
producing a sense of overwhelming and confusion in the user.

One example of that value are context menus where instead of always showing all options
to the user they show just the options for a particular topic and only when the user
requests it, for example after a right button click.

Popup context menus are modal dialogs. So are tooltips.

Edit in place has other problems that modal dialogs solve in a clear and explicit
way like commiting or rolling back an edition.

A modal dialog requires an explicit action to accept an edition and provides a clear
interface to dismiss the edition in case the user wants to roll it back.

Edit in place has ctl-z but that produces very different experiencies in the user: when is
a change applied in a edit in place field, when it loses focus, on every char typed,
when Enter is hit? Do I have to hit Enter or would that trigger a different action like
a form submit? Where would an Enter hit leave the focus? What if my change brakes
something in real time? Can I have a preview of the edition result before applying it for good?

All those questions are explicitly answered in a modal dialog interface.

### Small devices can use modals too

In smaller devices edit in place can be a nightmare for the ones that find it hard to
hit the proper field or button. It's a very common source of frustration to tap the
almost correct yet not exactly that one field.

If the app provides a temporary edition context where only the minimum information
is present it might improve the user experiencie even at the cost of 2 extra taps.

### Conclusion

Modal dialogs can be a way to improve and optimise the user experience while the
user solves a specific task and also while the user is not solving a specific
task by hiding the complexity until it's needed


[1] That technique is called 3D emulation because it achieves a visual effect of
depth using only 2 axis (x,y) for each point in the space. A real 3D model would
have three axis (x,y,z) for each point in the space. The effect of depth using
only 2 axis (x,y) is achieved by overlapping layers of 2D figures and moving each 2D
layer at a different speed and by applying different 2D transformations to different
parts of the same 2D figure such as making a 2D figure top wider than its base
