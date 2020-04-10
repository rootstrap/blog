## Yet another active form

Introducing [yaaf](https://github.com/rootstrap/yaaf), a gem to ease the usage of the form object pattern in rails apps.

### ~The~ My pain points

The form object pattern is widely used across Rails apps,
and yet we tend to write these form objects in a different manner from project to project.

Most of the time, they don't even have the same interface across form objects in the same app.

We also tend to write validations twice, in the model and in the form object,
just so that the form object has the errors and the view can display them.

Well, I can say that most of our in-house form objects make good use of database transactions.
But I bet we rarely provide the controller the ability to use a banged method,
expecting it to raise an error if things go south.

Business logic is present everywhere in your app, controllers, models, helpers (some hardcore scenarios might
include Rails initializers), but is that right? Many times we find ourselves with the need to add business logic
around the creation of an object, such as sending an email, updating other records or even calling an external service.
We know that the controller is not a good place, and the model would be terrible as well because it violates SRP.
So we end up creating several service objects and throwing the business logic there as if it were a trashcan.

### Instead of all of that, we can...

use yaaf, it solves all of that in an easy way, let me explain:

- Same interface? yaaf will encourage you to use `save` and just `save` to, well you know,
SAVE the data from your form into models.

- Contextual validations only? Please put them in your form objects, and keep data integrity validations where they belong,
in your service objects, haha no, of course not, those belong in your models!
yaaf will take the liberty to promote all model errors collections into the form object errors collection,
so you can show them in your views

- So, one of the form objects need to raise an error when not saved? As you may have guessed already,
use the _dangerous_ `save!` method.
yaaf already defines it so that it raises an error just as any Active Record model does.
Of course, it will also trigger a database rollback when the models couldn't be saved.
Both `save` and `save!` methods are available.

- Not sure where to put business logic related to the creation of an object? Well, the form object is the place.
yaaf will allow you to use callbacks the same way as your model callbacks work. For instance, if you want to send
an email after the form has been submitted and persisted, the `after_commit` callback is the one you're looking for.
More info can be found in the [readme](https://github.com/rootstrap/yaaf#callbacks).

### The Bob Ross of form objects

Using yaaf will allow you to standardize your form object definitions across your project's production code.

### Why not use this?

If you would rather have controllers deal with all these responsibilities, then it's fine to keep doing it,
you may not need yaaf if that's the case.

Are you a service-objects-for-all person?
Then you might feel better writing service objects rather than form objects.

If you work with Java, well you don't want to use this.

### A bit of history

We have been using this very same approach on a production app for almost a year now,
more than 10 form objects written this way,
and it has served us well.
That's why we decided to extract it to a gem.
(yaaf is no more than [64](https://github.com/rootstrap/yaaf/blob/master/lib/yaaf/form.rb#L64) lines currently,
and we need no more)

Big thanks to [@santib](http://github.com/santib) for shaping up this gem from its very beginning.

https://github.com/rootstrap/yaaf
