$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydra/object_viewer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydra-object_viewer"
  s.version     = Hydra::ObjectViewer::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Hydra::ObjectViewer."
  s.description = "TODO: Description of Hydra::ObjectViewer."
  s.license     = "APACHE2"

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "morphine"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-livereload'
end
