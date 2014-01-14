# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'crunchbase.rb'

Gem::Specification.new do |s|
  s.name = "crunchbase"
  s.version = Crunchbase::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Cunnion", "Brian Stearns"]
  s.email = "tyler.cunnion@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = Dir.glob("lib/**/*") + %w(LICENSE.txt README.rdoc)
  s.homepage = "http://github.com/tylercunnion/crunchbase"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby wrapper for CrunchBase API"
end

