class WolftechConnector

  def initialize
    # Establish and configure new LDAP connection
    #   See http://rubydoc.info/gems/ruby-net-ldap/0.0.4/Net/LDAP
    # TODO: This should be pulled out into a WolftechConnection class.

    @ldap = Net::LDAP.new({
      host: 'ldaps.wolftech.ad.ncsu.edu',
      port: 636,
      encryption: {
        method: :simple_tls,
        tls_options: { ca_file: '/etc/pki/tls/certs/ca-bundle.crt' }
      }
    })

    @ldap.auth WOLFTECH_CONFIG['username'], WOLFTECH_CONFIG['password']
  end

  def connect
    # bind to Wolftech using
    if @ldap.bind
      @ldap
    else
      raise 'Bind failed'
    end
  end

end
