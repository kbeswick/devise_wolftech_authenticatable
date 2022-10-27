require 'net-ldap-peer-verification'
require 'wolftech-authenticator'
require 'devise'
require 'devise/models/wolftech_authenticatable'
require 'devise/strategies/wolftech_authenticatable'
require 'devise_wolftech_authenticatable/version'

# for warden, :wolftech is just a name to identify the strategy
#Warden::Strategies.add :devise_wolftech_authenticatable, Devise::Strategies::WolftechAuthenticatable

# for devise, there must be a module named 'DeviseWolftechAuthenticatable' (name.to_s.classify), and then it looks to warden
# for that strategy. This strategy will only be enabled for models using devise and `:devise_wolftech_authenticatable` as an
# option in the `devise` class method within the model.
Devise.add_module :wolftech_authenticatable, strategy: true, route: :session, controller: :sessions, model: 'devise/models/wolftech_authenticatable'
