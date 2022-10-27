# DeviseWolftechAuthenticatable

Provides a Devise strategy for authenticating against WolfTech LDAP.

## Installation and configuration

1. Add the gem to your Gemfile:

```ruby
gem 'devise_wolftech_authenticatable', git: "git@github.ncsu.edu:ncsu-libraries/devise_wolftech_authenticatable.git", branch: 'master'
```

2. Copy **/config/initializers/wolftech.rb** to config/initializers in your project. This file contains username and password for connecting to Wolftech and **must not be included in a public repository**. It may be preferable to assign these values to `ENV` variables, which could be set either on the server or elsewhere in your project. In this case the initializer file might look something like:

```
WOLFTECH_CONFIG = { 'username' => ENV['wolftech\_username'], 'password' => ENV['wolftech\_password'] }
```

This version would be safe to include in a public repo as it does not contain sensitive information.


## Use with Devise (in Rails, Sinatra, etc.)

In your user model (User by default) include `:wolftech_authenticatable` at the beginning of your devise models:

```ruby
devise :wolftech_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
```


Now users who have email addresses that end with "@ncsu.edu" should be able to use their unity password. With the above configuration it is possible if the email address does not end with "@ncsu.edu" to use the database authentication strategy as a fallback for just those users. The WolfTech strategy requires the database authentication strategy to also be included.

## Use without Devise

See `bin/wolftech-auth` for a simple example of how to use the WolftechAuthenticator outside of Devise. There is an option to show the LDAP user entry that gets sent back when querying for a user. This data seems incomplete, so we may want to add some other utilities to this gem for getting fuller information.

## Getting LDAP User Attributes

I haven't figured out how to pass LDAP user entry through from Devise into the current user, but it is easy to get LDAP entries from both WolfTech and campus LDAP. The interface here might change but you can currently see examples of how to get user entries in the command line scripts in /bin.

WolfTech entries seem to have better group information, but might not have other information like address and phone.
```ruby
wolftech = WolftechAuthenticator.new
pp wolftech.get_ldap_user(unityid)
```

Campus LDAP seems to list fewer groups, but ought to have more information like address and phone.
```ruby
pp CampusLdap.entry_by_unityid(unityid)
```

## TODOs

Search the code for TODO and FIXME for a couple known issues that need to be addressed.
