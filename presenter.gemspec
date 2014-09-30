$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "presenter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "presenter"
  s.version     = Presenter::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Presenter."
  s.description = "TODO: Description of Presenter."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
