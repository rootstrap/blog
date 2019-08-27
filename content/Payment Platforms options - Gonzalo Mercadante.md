# Payment platforms for mobile apps

It’s common these days to see apps that offer to sell you in-app content on your mobile device. Sometimes they only sell virtual things like coins, diamonds, and credits that give users access to certain functionalities. But on a lot of e-commerce apps, like Amazon, you can buy physical goods. Both types of apps have platforms that manage payments. And there are many payment platform options to choose from. This article lists some of them, along with their pros and cons.

## What platforms are available?

You can’t always use the payment platform you want. You might want to sell virtual or digital goods on your app like coins and credits, but you don’t provide another way to do that like a web page. In this case, you must use in-app purchases to be approved by Apple. But if you run an e-commerce page where you sell solid goods like clothes, you can use other payment methods.


### Virtual goods

Many apps sell coins or credits that give users access to certain functions.
For these cases, buyers need to make in-app purchases. Most of the logic is managed in the frontend of these platforms. But because the payments are managed by Apple or Google inside the user’s device, the purchases also need to be validated on the app’s server.
As with any feature that has to do with money, security is of utmost importance when you implement in-app purchases. Specifically, it’s good to ensure that before you deliver paid resources to users, they actually pay for them. So after purchases are made, the frontend needs to send receipts to the server via encrypted data. Then the server needs to validate the receipt with Apple or Google servers.

### Physical goods

Many payment platform options are available for apps that sell physical goods. Some examples are Stripe, Braintree, Dwolla, and PayPal. Let’s look at each one.


### Stripe

Founded in 2011, [Stripe](https://stripe.com/) provides technical infrastructure to run online payment systems. With Stripe, both private individuals and businesses can accept online payments. This platform is one of the best payment options because it’s easy to implement and well documented. Stripe accepts currency from over 139 countries. And it automatically converts foreign money into your account’s currency. You can get Stripe in over 30 countries, but it accepts payments for almost all of them.
Stripe charges 2.9% plus $0.30 per transaction, and it supports subscriptions and discounts. The platform also gives volume discounts to big companies with more than $80,000 a month in sales. Accepted credit cards are Visa, MasterCard, American Express, JCB, Discover, Diners Club, and UnionPay. Stripe accepts international cards for an additional 1% fee. If the user’s payment currency is different than your payout currency, a 1% conversion fee also applies.
Stripe’s clients include Slack, Booking, Shoppify, Xero, National Geographic, and more.


### Braintree

Founded in 2007, [Braintree](https://www.braintreepayments.com/) was acquired by PayPal in 2013. Like Stripe, Braintree is well documented. And it takes payment in over 130 currencies.
Braintree’s basic fee is 2.9% plus $0.30 per transaction, and it supports subscriptions and discounts. This payment platform also gives volume discounts to big companies. Accepted credit cards are Visa, MasterCard, American Express, JCB, Discover, Diners Club, and UnionPay. With Braintree, you can also accept Venmo and PayPal. So if you need to include PayPal in your app, Braintree is a better choice than Stripe. The PayPal fee is charged directly from PayPal, but it’s the same as Braintree’s fee.
Braintree’s clients include Airbnb, Uber, Github, Dropbox, Skyscanner, and more.


### Dwolla

The [Dwolla](https://www.dwolla.com/) online payment solution is specifically designed for better bank transactions, customer management, and account verification. It doesn't support credit card payments. Dwolla’s enterprise pricing information is only available on request. To subscribe, you need to contact the company’s sales team. They currently charge a fixed fee per month that doesn’t depend on transaction amounts.
Dwolla’s clients include Goat, Sweep, Jane, Magento, Givetide, and more.


### Paypal

[Paypal](https://developer.paypal.com/) also offers an in-app platform that processes online payments. PayPal business account fees for sales within the U.S. are 2.9% plus $0.30 per transaction. For international sales, PayPal charges a 4.4% transaction fee plus a fixed fee based on the type of currency received.



## Marketplace payment platforms

A marketplace platform is an e-commerce where potential buyers and sellers connect to rent, buy, swap, or negotiate. On this type of platform, users can transfer money from their credit card or bank account to another person’s account. Three parties are involved: the platform owner, users who sell products or services on the platform, and buyers who purchase products from the sellers through the platform. A good marketplace platform takes care of payment processing, security, compliance, and fraud detection. It also distributes money between the three parties. Let’s review some options.


### Stripe Connect
With [Stripe Connect](https://stripe.com/connect), other Stripe accounts can connect to your Stripe marketplace account. After you integrate a partner’s Stripe account, the Stripe API can process payments from buyers and automatically transfer the proceeds to your seller partner. The seller becomes the merchant of record, and you, the marketplace owner, can charge an application fee for each transaction. Stripe Connect is easy to implement. To create merchant accounts, typically sellers, you need to verify them. The verification process depends on the country they’re in. To learn more, see [Identity Verification for Custom Accounts](https://stripe.com/docs/connect/identity-verification).


### Dwolla

Dwolla also offers a marketplace payment platform, but it doesn’t accept credit cards. In this case, it’s not necessary to verify both parts of the transaction. As an example, if you want to send money from your app to a seller’s account, you don’t need to verify the account because the app account is verified. Dwolla saves you money if you have many transactions because the fee is fixed. It's also easy to implement.


### Braintree

The Braintree marketplace payment platform isn’t available for everyone. To subscribe, you need to contact the sales team. But at this time, they aren’t accepting new Braintree merchants to their marketplace service.

### Paypal

PayPal has another platform called Adaptive Payments, but it’s currently a limited release product. Adaptive Payments is restricted to select partners for approved-use cases. You should not attempt to integrate this platform without guidance from PayPal.


### Which marketplace platform is best?

In most cases, we recommend Stripe Connect to support your marketplace app payments. Dwolla might be a better option if you don’t need a credit card platform.


## Summary

To conduct business, ecommerce stores that run on mobile apps need a payment platform that integrates with their website. Different platforms are designed to meet the different needs of online business. Variables include the type of items being sold, the payment methods required, and other factors.
Depending on the type of application you want to implement, you have several different payment platform options. Sometimes your possibilities depend on what your app sells. In other cases, your possibilities depend on the specific payment methods you can accept.
These guidelines sum it all up:
  • If you sell virtual items, you can only use in-app purchases for Apple.
  • If you need to accept PayPal, your options are either PayPal or Braintree.
  • If you want to accept credit cards, you can't use Dwolla.
  • If you need Alipay, you should use Stripe.
