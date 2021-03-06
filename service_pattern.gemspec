$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "service_pattern/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "service_pattern"
  s.version     = ServicePattern::VERSION
  s.authors     = ["kaspernj"]
  s.email       = ["kaspernj@gmail.com"]
  s.homepage    = "https://www.github.com/kaspernj/service_pattern"
  s.summary     = "ServicePattern for Ruby on Rails."
  s.description = "ServicePattern for Ruby on Rails."
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.5.0"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
