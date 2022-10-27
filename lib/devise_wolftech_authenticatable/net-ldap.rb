class Net::LDAP

  def initialize(args = {})
    @host = args[:host] || DefaultHost
    @port = args[:port] || DefaultPort
    @verbose = false # Make this configurable with a switch on the class.
    @auth = args[:auth] || DefaultAuth
    @base = args[:base] || DefaultTreebase
    @encryption = normalize_encryption(args[:encryption])

    # Certificate authority store - should of class OpenSSL::X509::Store
    # Used to store the root CA certificate, which can later be used to authenticate the peer certificate
    # of secure LDAP certificate
    cert_store args[:cert_store] # may be nil #ADDED

    if pr = @auth[:password] and pr.respond_to?(:call)
      @auth[:password] = pr.call
    end

    # This variable is only set when we are created with LDAP::open. All of
    # our internal methods will connect using it, or else they will create
    # their own.
    @open_connection = nil
  end

  # Function to set certificate store as instance variable
  def cert_store(args)  #ADDED
    @encryption[:cert_store] = args
  end
end
