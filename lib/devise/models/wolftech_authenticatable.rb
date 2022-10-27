# FIXME: Not sure if or why we might need to include this to make the gem work
module Devise::Models
  module WolftechAuthenticatable
    extend ActiveSupport::Concern

    module ClassMethods
      def find_for_wolftech_authentication(conditions)
        auth_key = self.authentication_keys.first
        return nil unless conditions[auth_key].present?
        auth_key_value = (self.case_insensitive_keys || []).include?(auth_key) ? conditions[auth_key].downcase : conditions[auth_key]
        auth_key_value = (self.strip_whitespace_keys || []).include?(auth_key) ? auth_key_value.strip : auth_key_value
        where(auth_key => auth_key_value).first
      end
    end
  end

end