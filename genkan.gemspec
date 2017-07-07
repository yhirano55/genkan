$:.push File.expand_path("../lib", __FILE__)

require "genkan/version"

Gem::Specification.new do |s|
  s.name        = "genkan"
  s.version     = Genkan::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.homepage    = "https://github.com/yhirano55/genkan"
  s.summary     = "Genkan is authentication engine for Rails"
  s.description = s.summary
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.3.0"

  s.add_dependency "rails", ">= 5.0"

  s.add_development_dependency "bundler", "~> 1.15"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
end
