# AppleAuth gem, Rails Apple Sing In integration

<img src="images/apple_auth.png" alt="Apple" />

## What is AppleAuth?

[AppleAuth](https://rubygems.org/gems/apple_auth) is a rootstrap developed Ruby gem to integrate Apple Sign In in our server side applications. 

## Why implement apple sign in in our projects?

This year, on the last iOS 13 release, "Sign in with Apple" login was one of the new features. At the same time the announce and update his App Store Review Guideline that if your ios app implements a third-party or social login service, like login with Facebook, will be mandatory to offer apple sign in as one option, by the end of April 2020.  Besides following the standards, implement this user authentication will let sign in using their two-factor authentication Apple ID. After the user follows Sign in with Apple to log in, your app receives tokens and user information that you can use to authenticate the user in your server.

### Apple sign-in workflow:
<img src="images/apple_sign_in_flow" alt="Apple" />
For more information, check [Apple Oficial Documentation](https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_rest_api)

## How AppleAuth works?

### Validate
Apple authentication flows OAuth 2.0, and our gem will help us with this flow. After the user sign-in in the client-side, on our server-side, we will have access to the user_identity, code, and JWT, the last one is a token that we will use to validate the user authentication with apple. First step Apple_Auth will decode and validate the JWT.

```
# with a valid JWT
user_id = '000343.1d22d2937c7a4e56806dfb802b06c430...'
valid_jwt_token = 'eyJraWQiOiI4NkQ4OEtmIiwiYWxnIjoiUlMyNTYifQ.eyJpc...'
AppleAuth::UserIdentity.new(user_id, valid_jwt_token).validate!
>>  { exp: 1595279622, email: "user@example.com", email_verified: true , ...}

# with an invalid JWT
invalid_jwt_token = 'eyJraWQiOiI4NkQsd4OEtmIiwiYWxnIjoiUlMyNTYifQ.edsyJpc...'
AppleAuth::UserIdentity.new(user_id, invalid_jwt_token).validate!
>> Traceback (most recent call last):..
>> ...
>>  AppleAuth::Conditions::JWTValidationError
```

### Authenticate
If we valivate sucseffly the JWT, we can autenticate them and ge users information. At this point we can persist refresh-token, to once a day, if it is needed get a fresh token from apple and ensure users that the user continues to have their apple_id validated.
```
code = 'cfb77c21ecd444390a2c214cd33decdfb.0.mr...'
AppleAuth::Token.new(code).authenticate!
>> { access_token: "a7058d...", expires_at: 1595894672, refresh_token: "r8f1ce..." }
```

### Devise Token Auth integration
If you already have DeviseTokenAuth gem inplemented on your rails project, you just can run this generator:

```
$ rails g apple_sign_in:appple_auth_controller [scope]
```
In the scope you need to write your path from controllers to your existent devise controllers and set up the routes.

It will create a controller , that implements AppleAuth metods, get the user's email, and register them.

You can find more info and the guide to install the gem on the [README](https://github.com/rootstrap/apple-sign-in-rails).
You can find a full implementation of this gem in this [demo](https://github.com/rootstrap/apple-sign-in-rails).
