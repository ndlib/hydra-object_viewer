$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydra-object_viewer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydra-object_viewer"
  s.version     = HydraObjectViewer::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HydraObjectViewer."
  s.description = "TODO: Description of HydraObjectViewer."
  s.license     = "APACHE2"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_development_dependency "rspec"
end
