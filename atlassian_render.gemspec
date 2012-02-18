# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "atlassian_render"

Gem::Specification.new do |s|
  s.name        = "atlassian_render"
  s.version     = AtlassianRender::VERSION
  s.authors     = ["Ryan Greenberg"]
  s.email       = ["greenberg@twitter.com"]
  s.homepage    = ""
  s.summary     = %q{A Redcarpet::Render class to convert Markdown to Atlassian markup}
  s.description = s.summary

  s.rubyforge_project = "atlassian_render"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "redcarpet", "~> 2.1.0"
  
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest", "~> 2.6.0"
end