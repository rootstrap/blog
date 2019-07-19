# Payment platforms for mobile apps

Nowadays, is very common to see apps that offer you in-app content. Sometimes they are just virtual things, like coins, diamonds, credits, which give users access to certain functionalities. But also, there are a lot of e-commerce apps, like Amazon, where you can buy physical goods.
Both types of apps are using payment platforms to manage the payments. And there are a lot of options you can use.
Let’s try to list some of them, along with some pros and cons.

## What payment platform should I use?

Not always you can use the platform you want. If you want to sell virtual/digital goods in your app (coins, credits, etc) and you’re not providing another way to do that (for example, a web page) then you must use In-app purchases to be approved by Apple. On the other hand, if you’re implementing an e-commerce page where you’re selling for example, clothes, then you can use other payment methods.


### Virtual goods

There are a lot of apps that use coins or credits to give the users access to certain functionalities, and for this case, you need to use In-app purchases. Despite the fact that most of the logic is managed in the frontend, because the payments are managed by apple/google in the device, the purchases should be validated also in the server.
As with any feature that has anything to do with money, security is very important when implementing in-app purchases. Specifically, it’d be good to ensure that when you’re providing a user with a paid resource, they have actually paid for it.
So, after the purchases are made, the frontend should send the receipt data to the server (encrypted data) and then the server should validate the receipt with apple/google servers.
Optionally, you can also validate the receipt in the frontend.

### Physical goods

For the apps that sell physical goods, there are more options to use. Some of them: Stripe, Braintree, Dwolla, Paypal.
Let’s take a look at each one.


### Stripe

Founded in 2011, Stripe provides technical infrastructure to operate online payment systems. It facilitates both private persons and business to accept online payments.
It’s one of the best payment options, easy to implement and with good documentation.
Accepts currencies from over 139 countries, and it automatically converts foreign currency into your account currency. It is available for over 30 countries, but accepts payments for almost all countries.
The fee is 2.9% + 0.30$ per transaction, and supports subscriptions and discounts. Also,
provides volume discounts for big companies, with more than $80.000 a month in sales.
Credit cards: Visa, MasterCard, American Express, JCB, Discover, Diners Club, UnionPay. Accept international cards for an additional 1%. If the payment currency differs from your payout currency, a 1% conversion fee will also apply

Some companies using stripe: Slack, Booking, Shoppify, Xero, National Geographic, etc.


### Braintree

Founded in 2007 and acquired by PayPal on Sep 26, 2013.
Similar to Stripe, they have a good documentation, and let you take payments in over 130 currencies, but charges an additional 1% fee for international payments.
The fee is 2.9% + 0.30$ per transaction and supports subscriptions and discounts. Provides volume discounts for big companies.
Credit cards: Visa, MasterCard, American Express, JCB, Discover, Diners Club, UnionPay.
Braintree allows you to accept Venmo and Paypal, so if you need to use Paypal in your app, then Braintree is better than Stripe. The fee for Paypal is charged directly from Paypal but it’s the same as Braintree.

Some companies using Braintree: Airbnb, Uber, Github, Dropbox, Skyscanner, etc.


### Dwolla

Dwolla is an online payment solution specifically designed for better bank transactions, customer management, and account verification. It doesn't offer credit card payments support.
Dwolla’s enterprise pricing information is available upon request. You need to contact the company sales team. Until now, they have a fixed fee per month (not depending on the transactions).

Some companies using Dwolla: Goat, Sweep, Jane, Magento, Givetide


### Paypal

Paypal also allows you to handle online payment processing, and it’s a more recognized platform. On the other hand, stripe is more like a “behind the scenes” processor with a brand name customers don’t necessarily recognize, but has a long list of popular clients.
PayPal business account fees for sales within the US it’s 2.9% + $0.30 per transaction, and for international sales, it’s 4.4% transaction fee plus a fixed fee based on currency received.
Paypal is easier to use but Stripe is meant for businesses that need a highly customizable and tech-based solution for payment processing. If you need more features and your emphasis is specifically online payments, the winner is Stripe.




## What are Marketplace payments?

A Marketplace platform is a form of e-commerce that connects potential buyers and sellers all within one platform to help rent, buy, swap or negotiate. It allows users transferring money from their credit card or bank account to another individual’s account. There are three parties involved: an **owner** that allow users with a product or service (**sellers**) to sell to many other users (**buyers**).
A Marketplace payments platform should take care of the payment processing, security, compliance, fraud detection and splitting the money between the parts.
Let’s review some options:

### Stripe Connect
Stripe Connect allows other Stripe accounts to connect to your Stripe marketplace account. Once a partner’s Stripe account is connected, the API can process payments from buyers and automatically transfer proceeds to sellers. The seller becomes the merchant of record and the marketplace owner is able to set an application fee on each transaction.
It’s easy to implement.
If you want to create merchant accounts (typically, the sellers) you need to verify them. The verification process depends on the country. [Here](https://stripe.com/docs/connect/identity-verification) you can take a look.


### Dwolla

Dwolla also offers a Marketplace platform. But it doesn’t accept credit cards.
In this case, it’s not necessary to verify both parts of the transaction, so for example, if you want to send money from your app to the seller account, you don’t need to verify the account since the app account is verified.
Dwolla is cheaper if you will have a lot of transactions because the fee is fixed.
It's easy to implement.


### Braintree

Braintree marketplaces is not available for all. You need to contact the sales team, but at this moment they are no longer boarding new Braintree merchants to their marketplace platform.

### Paypal

Paypal has a platform called Adaptive Payments but is now a limited release product. It is restricted to select partners for approved use cases and should not be used for new integrations without guidance from PayPal.

So, Stripe is the best marketplace in most of the cases, but sometimes Dwolla is a better option. It depends on the case.

## Summary

To sum up, depending on the type of application you want to implement, you will have different payment platform options. Sometimes, depends on what your app is selling, and other times, depends on specific payment methods you cant to accept. For example, if you are selling virtual things, then you need to use in-app purchases for Apple.
If you need to accept Paypal, the options are PayPal or Braintree. If you want to accept credit cards, you can't use Dwolla. If Alipay is a requirment, you should use Stripe.
