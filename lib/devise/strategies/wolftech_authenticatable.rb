module Devise
  module Strategies
    class WolftechAuthenticatable < Authenticatable
      def authenticate!
        # First we fail hard if there is no password. We do not want to pass on
        # to other strategies like the database strategy if there is no password.
        if password.empty?
          fail!
        else
          # Next we look up the user using the mapping to find the correct model.
          # Look at devise/mdoels/wolftech_authenticatable for the #find_for_wolftech_authentication
          # method that looks up the user in the database.
          user = mapping.to.find_for_wolftech_authentication(authentication_hash)
          # Fail hard if there is no matching user. Do not continue to try to authenticate.
          if !user
            fail!
          else
            # The user must have an email attribute.
            email = user.email
            # If email does not match @ncsu.edu then pass it to the next strategy.
            # This allows for having the database strategy as a backup.
            if email.match /^(.*)@ncsu\.edu$/
              # Use the first match group as the unity_id to look up.
              unity_id = $1
              wolftech = WolftechAuthenticator.new

              # If the Wolftech bind succeeds with this password login is a success.
              # If the Wolftech bind fails then pass to the next strategy.
              if wolftech.authenticate(unity_id, password)
                success! user
              else
                fail
              end
            else
              fail  # should pass on to another strategy
            end
          end
        end
      end
    end
  end
end

Warden::Strategies.add(:wolftech_authenticatable, Devise::Strategies::WolftechAuthenticatable)