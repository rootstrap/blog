# How to think load tests

## Introduction

Recently i had to do some load tests for an app and interpret the results.
The client provided me with data about how the application was used and then i had to
dimensionate servers and run load tests against them.
After the test ran. i had to recopile the data and redimensionate the servers accordingly.


I've decided to do a series of posts about what i've learned.

## Making the test model

In this part you have to make some assumptions.
Let's say your client wants to load test an application for a fast food store
where you can redeem some coupons to get an instant benefit in your lunch
and allows the user to register himself in the application to implment some sort of
loyality program.

The client tells you that he expects to have 500.000 monthly users by the end of the month.
From that user mass he expects that the 65% are annonymus users that redeem coupons ocasionally
and the other 35% will be returning users.
You also know that 30% of the users will register themselves in the royality program after the
discount is redeemed.

### Initial assumptions

Now we have to turn this data into concrete numbers
With this in mind, we can assume that the application will be used mostly on lunch hours, so
most of the users will concurr at that time.
Let's make the following assumptions:
- We're at rush hours of the buisiness
- The 80% of the app uses are made during rush hours.
- All days have the same user load
- The client flow is somewhat constant during that hours

### Doing the math

With that in mind lets do some math:
 - 400.000 is the 80% of 500.000
 - from that we have two distinct groups:
 - - 260.000 New users (The 65% of all users)
 - - 78.000 Users that will register themselves in the loyality program (This is 30% of the new users)
 - 140.000 Returing users using the loyality program

Now, a month has 30 days and for each day the rush hours are from 11:30 to 14:00 and from 20:00 to 21:30.
Then we should adjust our math to see how many user traffic we have in an hour.
Since we have 4 rush hours we should divide every number we have until now between 120 to get how many users
we get per hour on average. That gives us:

- 3334 Total users
- 2167 New users
- - 650 Of that new users will register themselves in the app
- 1167 Returning users

But we're gonna run our tests during 15 minutes, so we have to divide this numbers again getting:

- 833 Total users
- 541 New Users
- - 163 of that users will sign up for the app
- 292 Returning users

And that's our user base for the Load tests!

In the next post i will define user flows and set up Apache Jmeter to perform them.

Thanks for reading!
