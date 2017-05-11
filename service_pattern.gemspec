$LOAD_PATH.push File.expand_path("../lib", __FILE__)

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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "sqlite3"
end
