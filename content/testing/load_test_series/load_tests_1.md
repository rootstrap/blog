# Load Testing with Apache JMeter.

## Introduction

Recently, one of our clients asked us to evaluate the performance of their app in a production environment. To give that evaluation, we need to answer several questions:

- How will the current configuration perform in real life?
- Does this configuration scale acording to client expectations?
- Where are the bottlenecks?
- How should our client scale to solve those bottlenecks?

Based on these criteria, we decided that performing load testing is the best way to answer these questions. Here's how we did it.

## What Is Load Testing?

Load testing is a type of test that tries to measure an application's performance under normal, expected user loads. With this type of test we can measure the users' experience of the app, collecting metrics like response times and error rates that can give us insight into the performance and efficiency of the software. This info allows us to emulate the day to day experience that clients and users will have with the app, then use that to plan how to scale the platform as the user base grows. This also allows us to set an objective criteria about what is acceptable and what is not.

### What Load Testing Isn't

Keep in mind that a load test is _not_ a stress test. Load testing doesn't try to cover every bit and every endpoint of our app. Instead, it gives us a general insight into the general user experience under the expected traffic of the app.

### Load Tests vs Stress Tests

Even tough the testing flow is similar, the mindset for load tests and stress tests is totally different.

In stress tests, we try to overload the app to see when it breaks. Usually these tests cover extreme scenarios that are far more demanding than what we expect from the usual flow.

Stress tests are useful to recreate concrete scenarios of how the program will behave during peak traffic, such as:

- How the telephone network will behave on christmas.
- How our streaming app will perform in the season finale of our most watched series.

Even though the above scenarios are very real, they do not represent the usual workload of an app. That's why we differentiate between stress tests and load tests. 

## Simulation of Users: Load Testing
### Reality Model

_¨All models are wrong, but some are useful¨_ - George Box

Before we begin, we need to make a few assumptions.

Let's say our client wants to load test an application for a fast food store where the users can redeem coupons to get an instant discount on their lunch. The app also lets users register themselves and take advantage of a loyalty program.

The client tells us that they expect to have 500.000 monthly users by the end of the month. From that user base, they expect that 65% are anonymus users that redeem coupons occasionally, while the other 35% will be returning users. We also know that 30% of the users will register in the royality program after the discount is redeemed.

### Initial Assumptions

Now that we have our assumptions, we need to turn this data into concrete numbers.

With this in mind, we can assume that the application will be used mostly during lunch hours, so most of the traffic will happen at lunchtime. 

Let's make the following assumptions:

- We're at rush hours of the business.
- 80% of the app uses are made during rush hours.
- 80% of the users are active during rush hours.
- All days have the same user load.
- The client flow is somewhat constant during these rush hours.

Let's translate this into a simple Venn diagram to vizualize the user groups that we have:

![Alt](images/Blog-Load-Tests.png)

### Doing the math

With that in mind, let's do some math:

 - 80% of our 500,000 user base gives us 400,000 users during typical load.
 - We can divide our 400,000 into two distinct groups:
   - 260,000 new users (65% of all users).
    - 78,000 users that will register in the loyalty program (this is 30% of the new users).
   - 169,000 returning users using the loyalty program.

Let's assume 30 days in a month, with each day having rush hours from 11:30 am to 12:30 pm and from 08:30 pm to 09:30 pm. Now we should adjust our math to see how much user traffic we have in an hour.

Since we have 2 rush hours, we'll divide every number we have up to now by 120 to get how many users we get per hour on average. Keep in mind that we're only taking 80% of our total user numbers, as that's the percentage that use the app during rush hours.

That gives us:

- 5,715 total users.
- 3,715 new users.
    - 1,115 of that new users will register in the app.
- 2,415 returning users.

But we still have some dividing to do: we'll only run our tests for 15 minutes, so we need to divide these numbers again to get the rough number of users for our tests. These 15 minutes are known as ramp-up time. What we need to do now is homogeneously distribute the user input in this period of time.

Why do we distribute users homogenously? Even tough there will be some concurrent usage of the app, it's a discount app: the vast majority of users will use it once during the 1-hour period and log off. Most users won't be using the app for the full load period.

Now, we'll assign every user with a user flow and have that user execute it once during our 15 minute test period. If the start time is random, and all the start times are equally probable, we should get a fairly equal distribution of users in the ramp up time.

So the final numbers are:
- 1,429 total users.
- 929 new users.
    - 279 of that users will sign up for the app.
- 604 returning users.

Note that with this model we're not considering things like:

- Short bursts of users in one or two minutes
- A user retrying his flow if he fails the first time.

Even though we're not considering these possible scenarios, this model should give us a fairly good idea of how our app performs on a day to day basis.

### Modeling Scalability with Load Testing

But we're not quite done: we also need to model how our app is going to scale over time. For this, we'll need to make one more assumption: the user flows are still the same as the user base grows and no flows will be added.

With that in mind, the only thing left to do is play with the user base of the app and adjust the number of users to see how it performs as the user base grows. But thankfully, we've already defined our model of reality. That means scaling it up or down is easy. All we have to do is modify the number of users that will be running concurrently.

One great way to approach this is to start by dividing the user base provided by the client by 100, 75, 50, and 25. After the calculations are rerun, we'll have five scenarios that represent different user bases with the same flows in consideration.

If we want to scale further than the user base provided by the client, we can multiply by 1.25, 1.5, and 1.75 to get an idea of that. A simple excel sheet can help us keep track of how many users every scenario has.

And that's our user base for the load tests.

But that's certainly not the full extent of load testing. In our next post, we'll define user flows and set up Apache Jmeter to perform them.


Thanks for reading!
