lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'snapshot/version'
 
Gem::Specification.new do |s|
  s.name        = 'snapshot-ruby'
  s.version     = Snapshot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jeremy Boles']
  s.email       = ['jeremy@jeremyboles.com']
  s.homepage    = 'https://github.com/jeremyboles/snapshot-ruby'
  s.summary     = 'Ruby wrapper for storing and manipulating images via Snapshot.'
  s.description = 'Snap is a very simple image storage and processing services for developers.'

  s.required_rubygems_version = '>= 1.3.7'
  s.rubyforge_project         = 'snapshot-ruby'
  
  s.add_dependency 'json', '1.6.5'
  s.add_dependency 'rest-client', '1.6.7'
  
  s.add_development_dependency 'fakeweb', '1.3'
  s.add_development_dependency 'rspec', '2.4.0'

  s.files        = Dir.glob("lib/**/*") + %w(README.md)
  s.require_path = 'lib'
end