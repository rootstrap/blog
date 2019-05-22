Sometimes we want to add filters in an ActiveAdmin model page that use scopes that are not just a simple 'where' clause applied to only one column of the table.

For that we need to define the filter like this:

[sourcecode language="ruby"]
# app/admin/my_model.rb
filter :my_custom_filter,
         as: :numeric,
         label: 'Custom Filter',
         filters: [:eq]
[/sourcecode]

We define in the model the scope or the class method that returns an Active Record Relation:

[sourcecode language="ruby"]
# app/models/my_model.rb
def self.my_custom_filter_eq(value)
  where(column_1: value) # or probably a more complex query that uses the value inputted by the admin user
end
[/sourcecode]

And finally we also need to tell that the scope is ransackable, for which we add also in the model:

[sourcecode language="ruby"]
# app/models/my_model.rb
  def self.ransackable_scopes(_auth_object = nil)
    %i(my_custom_filter_eq)
  end
[/sourcecode]

In this example we assumed we wanted to create a filter that receives a numeric value as a param, and the querying options are limited to just equality. You can play around with the other predicates or change the param types.

For example, now let's add a filter that uses a date range for a custom column.

Suppose your model has a belongs to relation with the user model, and the user has an activation date. Now you want to filter the records belonging to a user that activated between two dates.

In the admin model:

[sourcecode language="ruby"]
# app/admin/my_model.rb
  filter :activated_in_period,
         as: :date_range,
         label: 'Of user activated during period'
[/sourcecode]

In the model:

[sourcecode language="ruby"]
# app/models/my_model.rb
  def self.ransackable_scopes(_auth_object = nil)
    %i[activated_in_period_gteq_datetime activated_in_period_lteq_datetime]
  end

  def self.activated_in_period_gteq_datetime(date_from)
    joins(:user).where('users.activation_date >= ?', date_from)
  end

  def self.activated_in_period_lteq_datetime(date_to)
    joins(:user).where('users.activation_date <= ?', date_from)
  end
[/sourcecode]

And that's it. This is the foundation for many other types of custom filters we want to create.
