$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "genkan/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "genkan"
  s.version     = Genkan::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Genkan."
  s.description = "TODO: Description of Genkan."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "sqlite3"
end
