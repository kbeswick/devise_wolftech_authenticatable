require_relative 'net-ldap-peer-verification'
require_relative 'devise_wolftech_authenticatable/wolftech_connector'

class WolftechAuthenticator

  def initialize
    connector = WolftechConnector.new
    @connection = connector.connect
    # @base_dn is used to get user's dn during authentication
    @base_dn = 'ou=people,dc=wolftech,dc=ad,dc=ncsu,dc=edu'
  end

  def get_ldap_user(unity_id)
    filter = Net::LDAP::Filter.eq('sAMAccountName', unity_id)
    user = @connection.search(:base => @base_dn, :filter => filter).first
  end

  def authenticate(unity_id, unity_password)
    # Find user with given unity_id
    #  See http://rubydoc.info/gems/ruby-net-ldap/0.0.4/Net/LDAP/Filter
    user = get_ldap_user(unity_id)

    # Autheticate by attempting to bind using user's dn and unity password
    @connection.auth user.dn, unity_password
    if @connection.bind
      user
    else
      false
    end
  end

end
