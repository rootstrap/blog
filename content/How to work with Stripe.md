# **Online payments made SIMPLE - How to work with Stripe**

![main image](images/payment.jpg)

Here at [Rootstrap](https://www.rootstrap.com/mobile-app-development-los-angeles/), we care about not reinventing the wheel and making things simple (along with high quality of course).

In this blog post, you’ll learn how to start working with Stripe and quickly have fully functioning online payments in your apps.


## 1) WHY STRIPE?

Pros

 - Easy to implement and use

 - Fast to develop, so your client will be happy

 - Solves most of your usual payment problems, so you don't lose time or clients (even worst)

 - Amazing dashboard with a lot of capabilities so your clients financial team can work along with you

Cons

 - Expensive (high % fee)

## 2) INSTALLATION

This post assumes you already created a Stripe account and so you have access to dashboard and its configuration.

#### RAILS

- Add these two gems:
    - [Stripe](https://github.com/stripe/stripe-ruby) to achieve the integration
    - [Stripe Testing](https://github.com/stripe-ruby-mock/stripe-ruby-mock) to test your integration, you don't want to end up writing lots of mocking classes, right?
- Configure your keys & version from the Stripe dashboard

https://gist.github.com/fedeagripa/0ae76f1f2a5b77f0a12fdbc2eeaa5904

#### REACT

- Add this package [Stripe](https://github.com/stripe/react-stripe-elements)
- Configure your App to use the same api key as for rails (make sure it is the same, as you start moving between envs you may forget it). Remember that there is a testing key and a live one.

Add an env file to store your keys
https://gist.github.com/fedeagripa/5f99c824308ba899d6f7deb5fb85ff76

Add your Stripe wrapper

https://gist.github.com/fedeagripa/f2f64556a820abf9b377fa16f256d0d2

## 3) START USING PAYMENTS WITH STRIPE

### CREDIT CARDS

##### REACT - DO YOURSELF A FAVOR AND USE THE EXISTING COMPONENT

I'm not a fan of reinventing the wheel by any means, the design this components provide are more than enough for 99% of the apps you will be building. But if you insist, be prepared to spend 2 weeks dealing with details instead of 2 days.

https://gist.github.com/fedeagripa/385cb4c4f9ccf66f833749349a41426a


##### RAILS - DON'T TRY TO STORE ALL THE INFO (IT'S ILEGAL)

You will tend to store more credit card info that you need. The only info that you need to store in your database (for basic usage) is:
  - `customer_id` : Stripe customer identifier that you will store in your User for example
  - `card_id` : Stripe card identifier

The `token_id` you will get from your frontend is a short lived token that is only needed for an atomic operation.

Add a `customer_id` field to your user (or Shop in next example).
Add a `card_id` to your user (or Shop in next example).

Now take this service example (Shopify page example):
https://gist.github.com/fedeagripa/478e2c3a1e5eb018341740504fcb272f

And this simple controller:

https://gist.github.com/fedeagripa/29f02be2c8ab39560d06de47e13c7681

And that's all! You can start charging your users now!
All fraud detections and customer service actions can be managed directly from Stripe's dashboard.

### SUBSCRIPTIONS
To create a subscription you need to define it, then create a product in Stripe (this last one is really clear looking at the dashboard, so i'm not going to explain it)

##### CREATING THE SUBSCRIPTION
https://gist.github.com/fedeagripa/538df087957a2019e8444417347a32ac

In that model you will store attribures like: `expires_at`, `type` or even `provider` if later you want to extend to other providers like PayPal or Apple Pay

Finally to create them on Stripe is quite simple:

https://gist.github.com/fedeagripa/d49a024299d2b8e315ff0861d32e9534

### COUPONS
Coupons are the abstract concept of `30% off` for example, when you apply that coupon to a user that's called a `discount`.
So you should define some discounts on Stripe and store their ids in your database to apply them to users.
There are two types of coupons `percentage` & `fixed amount`, and any of them can be one time only or have the capability to be applied multiple times. So when you try to apply a coupon to a subscription for example, remember that it can fail if you reached the maximum usage number.

Another useful case that is worth mentioning is to apply a coupon to a user, this means that they will have a positive balance for any future invoice (be careful if you charge users with multiple products)

### SUBSCRIPTION ITEMS
These are your billing items, so for the case of a web subscription you will just have 1 subscription item. For specific cases like an amazon cart or any complicated use case (where you have multiple items being added to a purchase) is where you have to start considering adding some specific logic to your app.
I won't get really into detail about this, I just wanted to show the general concept behind this, maybe I will write more in detail in a future post.

##### RENEWALS
Don't overthink it, there is a webhook for most of your use cases. But for this specific need you can configure the following events:

 - customer.subscription.updated
This event happens every time a susbscription is updated according to this [documentation](https://stripe.com/docs/billing/subscriptions/change)

 - customer.subscription.deleted
As simple as it sounds, it tells you when a subscription is canceled so you can take the actions needed in your app (possibly dissable the associated account)

 - invoice.payment_succeeded
This is a really important one! It tells us when a payment is actually accepted by the credit card provider (some times they can be fraud or declined)

### WEBHOOKS
There are a lot of them and they will solve most of your problems, the only downcase is the headache trying to understand which exactly to use.
I'm sorry to dissapoint you if you reached here trying to answer this question but up to now I only know [this page](https://stripe.com/docs/api/events/types) that explains the different existing webhooks and what they do. The other option is when you go to create a webhook from the developer's Stripe dashboard, they explain a bit more in detail what each event does.

## 4) SPECIAL RECOMMENDATIONS FOR FURTHER PAYMENT IMPLEMENTATION
Keep these Stripe documentation pages as your friends:
 - [Devs api](https://stripe.com/docs/api/)
 - [Events types](https://stripe.com/docs/api/events/types)

Sometimes there are two or even three ways of solving a problem, so consider this and take your time to analyze each requirement properly before you start coding.

## 5) CONCLUSIONS
You can easily add online payments to your app and test it in just 1 week (or so), thats amazing! The other amazing thing is that you can start managing most of the daily based situations like fraud of disputes just from the dashboard (you don't need to keep coding).

The difficult part of this is when you start adding more concrete and detailed transactions and supporting multiple transfers types (like bank account tranfers instead of just Visa or MasterCard). So if you liked this post and want to know more don't hesitate to leave some comments asking for it!

