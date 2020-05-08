# **ActiveAdmin 2FA with OneLogin**

![main image](images/2fa.jpg)

Here at Rootstrap, security is one of the most important topics we discuss with our clients. We ensure that hackers and cyber-thieves can’t access any sensitive information from our client’s web apps.

In this blog post, you’ll learn how to configure two factor authentication with OneLogin for your admin panel


##
**1) Some key concepts**

 - SLO

 - SSO

 - Callback URL

 - Certificate

##
**2) How to start with all this work?**


First take a look at this lovely [gem](https://github.com/apokalipto/devise_saml_authenticatable), you will notice that all the examples are for the `User` class, but don't worry we will show some examples for admin specifically

The specific lines you need to add are:

``` ruby
# app/models/admin_user.rb

devise :recoverable, :rememberable, :trackable, :validatable, :lockable, :saml_authenticatable
```

``` ruby
# config/attribute-map.yml

"urn:mace:dir:attribute-def:email": "email"
```

``` ruby
# You can customize the named routes generated in case of named route collisions with
  # other Devise modules or libraries. Set the saml_route_helper_prefix to a string that will
  # be appended to the named route.
  # If saml_route_helper_prefix = 'saml' then the new_user_session route becomes new_saml_user_session
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

Finally we need to modify devise to use our new login strategy. To achive this we will modify the session management and redirect to our third party provider like this:

```ruby
# app/controllers/admin_users/sessions_controller.rb

module AdminUsers
  class SessionsController < Devise::SessionsController
    # As you are overwriting devise session controller you need this to allow to login with user & pass (dev mode)
    prepend_before_action :require_no_authentication, only: [:new, :create]

    layout 'active_admin_logged_out'
    helper ::ActiveAdmin::ViewHelpers

    def new
      unless Rails.env.development? || SettingsStore.get(:admin_sso_enabled)
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

As you can see in the initializer there is some conditionals for development, that's because there is no dev out there that wants to do a 2FA every time they work locally
So we still need to add some code to conditionally enable 2FA depending on the environment, and a flag (bacause we don't want to block access to admin if something happen to OneLogin also)

We need to check:
  - Development usual admin login page works
  - Turning feature off uses old admin login and it works
  - How logout works




##
**3) Conclusions**



<!-- Docs to Markdown version 1.0β17 -->
