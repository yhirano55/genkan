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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
end
