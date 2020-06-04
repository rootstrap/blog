# **ActiveAdmin 2FA with OneLogin**

![main image](images/2fa.jpg)

Here at [Rootstrap](https://www.rootstrap.com/mobile-app-development-los-angeles/), security is one of the top priorities, for us and for our clients. We ensure that malicious users can’t access any sensitive information from our client’s web apps.

In this blog post, you’ll learn how to configure two factor authentication with OneLogin for your admin panel.


##
**1) Some key concepts**

 - SLO (Single log out): SLO is a process that allows users to be logged out in one place and spread it over multiple applications

 - SSO (Single sign in): SSO is a process that allows users to authenticate into multiple services after logging into a primary service

 - Callback URL: It is a local URL in your app where a third party auth provider sends you auth data like confirmations or logout requests


##
**2) How to start with all this work?**


First take a look at this lovely [gem](https://github.com/apokalipto/devise_saml_authenticatable), you will notice that all the examples are for the `User` class, but don't worry we will show some examples for admin specifically

The specific lines you need to add are just a few ones:

First add the devise `saml_authenticable` module from our choosen gem, this will inject most of the needed capabilities.
``` ruby
# app/models/admin_user.rb

devise :recoverable, :rememberable, :trackable, :validatable, :lockable, :saml_authenticatable
```

Then tell `saml_authenticable` module which SAML fields you want to map to your model ones
``` ruby
# config/attribute-map.yml

"urn:mace:dir:attribute-def:email": "email"
```

Almost done, add some configuration to your devise initializer to configure the communication between your third party provider and devise.
You can customize the named routes generated in case of named route collisions with other Devise modules or libraries. Set the saml_route_helper_prefix to a string that will be appended to the named route.
If saml_route_helper_prefix = 'saml' then the new_user_session route becomes new_saml_user_session
``` ruby
# config/initializers/devise.rb

config.saml_route_helper_prefix = 'saml'
callback = Rails.env.development? ? 'http://localhost:3000' : ENV['SAML_CALLBACK_ADDRESS']
# SAML configuration
config.saml_create_user = true
config.saml_update_user = true
config.saml_default_user_key = :email
config.saml_session_index_key = :session_index
config.saml_use_subject = true
config.idp_settings_adapter = nil
config.saml_configure do |settings|
  settings.assertion_consumer_service_url     = "#{callback}/admin/saml/auth"
  settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
  settings.name_identifier_format             = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
  settings.issuer                             = "#{callback}/admin/saml/metadata"
  settings.authn_context                      = ""
  settings.idp_slo_target_url                 = "https://company.onelogin.com/trust/saml2/http-redirect/slo/#{Rails.env.development? ? '1234' : ENV['SLO_TARGET']}"
  settings.idp_sso_target_url                 = "https://company.onelogin.com/trust/saml2/http-post/sso/#{Rails.env.development? ? 'you_sso_string' : ENV['SSO_TARGET']}"
  settings.idp_cert_fingerprint               = Rails.env.development? ? 'your_cert_fingerprint' : ENV['IDP_CERT_FINGERPRINT']
  settings.idp_cert_fingerprint_algorithm     = 'http://www.w3.org/2000/09/xmldsig#sha256'
end
```

Finally, we need to modify devise to use our new login strategy. To achieve this we will modify session management so it redirects to our third party provider like this:

```ruby
# app/controllers/admin_users/sessions_controller.rb

module AdminUsers
  class SessionsController < Devise::SessionsController
    # As you are overwriting devise session controller you need this to allow to login with user & pass (dev mode)
    prepend_before_action :require_no_authentication, only: [:new, :create]

    layout 'active_admin_logged_out'
    helper ::ActiveAdmin::ViewHelpers

    def new
      unless Rails.env.development? || Rails.env.test?
        return redirect_to :new_saml_admin_user_session
      end

      super
    end
  end
end
```

```ruby
# config/initializers/active_admin_devise.rb
module ActiveAdmin
  module Devise
    def self.controllers
      {
        sessions: "admin_users/sessions",
        passwords: "active_admin/devise/passwords",
        unlocks: "active_admin/devise/unlocks",
        registrations: "active_admin/devise/registrations",
        confirmations: "active_admin/devise/confirmations"
      }
    end

    def self.controllers_for_filters
      [
        ::AdminUsers::SessionsController,
        SessionsController,
        PasswordsController,
        UnlocksController,
        RegistrationsController,
        ConfirmationsController,
      ]
    end
  end
end
```

###
**And that's all? wow!!!**

Well.... not really, sorry for getting you excited ¯\\_(ツ)_/¯

As you can see in the initializer there are some conditionals for development, that's because there is no dev out there that wants to do a 2FA every time they want to access ActiveAdmin locally.
So we still need to add some code to conditionally enable 2FA depending on the environment, and a flag (because we don't want to block access to admin if something happens to OneLogin also)

We need to check:
  - Usual admin login page works in development
  - Turning the feature off uses the old admin login and it works
  - How logout works


To perform the first two points I ended up adding the next lines to our overridden sessions_controller, seems that they are lost from super as you override it

``` ruby
# app/controllers/admin_users/sessions_controller.rb

prepend_before_action :require_no_authentication, only: [:new, :create]
prepend_before_action :allow_params_authentication!, only: :create
prepend_before_action :verify_signed_out_user, only: :destroy
prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
```

**How logout works**

At this point you have 3 options to logout:
  - destroy your app session
  - destroy saml session
  - force logout from your third party auth partner

For this specific case, we needed to perform the first one only, because logging someone out of OneLogin means they will be logged out of a lot of apps, and that was not desired.
Actually it was a pain in the neck to do this, because `devise_saml_authenticable` gem adds routes using `class_eval` approach directly to `Devise` engine, leaving you with almost no way to configure which routes you really want or not. You will be asking yourself `Why would I like to remove a route?`, well... that's because at this point you have 2 `admin/logout` routes in your app, and we know this is not a good practice at all.
I ended up with this solution as the "cleanest":

``` ruby
# config/initializers/devise.rb

ActionDispatch::Routing::Mapper.class_eval do
  protected
  def devise_saml_authenticatable(mapping, controllers)
    if ::Devise.saml_route_helper_prefix
      prefix = ::Devise.saml_route_helper_prefix
      resource :session, only: [], controller: controllers[:saml_sessions], path: '' do
        get :new, path: 'saml/sign_in', as: "new_#{prefix}"
        post :create, path: 'saml/auth', as: prefix
        get :metadata, path: 'saml/metadata'
        match :idp_sign_out, path: 'saml/idp_sign_out', as: "idp_destroy_#{prefix}", via: [:get, :post]
      end
    else
      resource :session, only: [], controller: controllers[:saml_sessions], path: '' do
        get :new, path: 'saml/sign_in', as: 'new'
        post :create, path: 'saml/auth'
        get :metadata, path: 'saml/metadata'
        match :idp_sign_out, path: 'saml/idp_sign_out', via: [:get, :post]
      end
    end
  end
end
```
You can add last lines at the end of your devise initializer, or even better create a new initializer that run after devise one.


##
**3) Conclusions**

A project that was estimated to last over a month or so, ends up tacking only 2 weeks because we found a great gem that solves most of our problems (besides some gem implementations not being done in the best way).
Work does not end here, besides sharing this I'm planning to contributing back to this awesome gem to improve its quality and support missing points we mentioned. And my goal with this post besides showing how to solve a security problem is to encourage others to contribute back when you see you can do it, without contributions like this, this gem wouldn't exist and neither would this post.
