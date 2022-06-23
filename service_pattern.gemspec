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
  s.required_ruby_version = ">= 2.7.0"
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "appraisal"
  s.add_development_dependency "best_practice_project"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rails", ">= 6.0.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "tzinfo-data"
end
