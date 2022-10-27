$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_wolftech_authenticatable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_wolftech_authenticatable"
  s.version     = DeviseWolftechAuthenticatable::VERSION
  s.authors     = ["Jason Ronallo"]
  s.email       = ["jronallo@gmail.com"]
  s.homepage    = ""
  s.summary     = "Wolftech authentication made easy with Devise"
  s.description = "Wolftech authentication made easy with Devise"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "bin/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.executables << 'wolftech-auth'

  # Lock net-ldap to 0.12.1 due to this issue:
  # https://github.ncsu.edu/ncsu-libraries/devise_wolftech_authenticatable/issues/4
  # s.add_dependency "net-ldap", '~>0.12.1'
  s.add_dependency "net-ldap"
  s.add_dependency 'devise'
  s.add_dependency 'highline'
  s.add_dependency 'slop', '3.6.0'

end
