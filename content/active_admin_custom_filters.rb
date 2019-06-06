*[Leticia Esperon](https://www.rootstrap.com/tech-blog/author/letiesperon/) is a backend developer on the Rootstrap team and writes about her experience tackling difficult problems for  our many clients. You can also follow Leticia on [LinkedIn](https://www.linkedin.com/in/leticia-esperon-0ba955127/).*

On an ActiveAdmin page, filters can help make information more usable. But sometimes, we need to add filters that are more complex than normal, going beyond a simple 'where' clause applied to only one column of the table.

To achieve this, we'll start by defining the filter like this:

[sourcecode language="ruby"]
# app/admin/my_model.rb
filter :my_custom_filter,
         as: :numeric,
         label: 'Custom Filter',
         filters: [:eq]
[/sourcecode]

In the model, we'll then define the scope or the class method that returns an Active Record Relation:

[sourcecode language="ruby"]
# app/models/my_model.rb
def self.my_custom_filter_eq(value)
  where(column_1: value) # or probably a more complex query that uses the value inputted by the admin user
end
[/sourcecode]

And finally, we'll need to specify that the scope is ransackable. This means we'll add the following to the model:

[sourcecode language="ruby"]
# app/models/my_model.rb
  def self.ransackable_scopes(_auth_object = nil)
    %i(my_custom_filter_eq)
  end
[/sourcecode]

This example assumes we want to create a filter that receives a numeric value as a parameter, and for simplicity, we've limited the querying options to equality. But that's just one possibility – you can play around with other predicates and change param types to see what's most useful in your case.

As an example, let's add a filter that uses a date range for a custom column.

Suppose your model has a 'belongs to' relation with the user model, and the user has an activation date. Now, you want to filter the records belonging to a user that activated between two dates.

Here's what goes in the admin model:

[sourcecode language="ruby"]
# app/admin/my_model.rb
  filter :activated_in_period,
         as: :date_range,
         label: 'Of user activated during period'
[/sourcecode]

And in the model:

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

And that's it! We've only used a couple of examples here, but this code structure is the foundation for many other types of custom filters we want to create, so you can tweak it to achieve a variety of goals. 

*At Rootstrap, we solve problems like this one – and much bigger problems – day in and day out. If your company could use a hand with its technical challenges, we'd be thrilled to talk them over with you either at a high or a technical level. Drop us a line [here](https://www.rootstrap.com/contact), or feel free to reach out to [Justin@rootstrap.com](mailto:justin@rootstrap.com) and he'll arrange a free consultation with a member of the Rootstrap technical team.*

