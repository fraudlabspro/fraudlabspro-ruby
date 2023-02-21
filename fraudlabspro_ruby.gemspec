# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fraudlabspro_ruby/version"

Gem::Specification.new do |s|
  s.name          = "fraudlabspro_ruby"
  s.version       = FraudlabsproRuby::VERSION
  s.authors       = ["fraudlabspro"]
  s.email         = ["support@fraudlabspro.com"]
  s.summary       = "FraudLabs Pro Ruby SDK"
  s.description   = "A Ruby SDK enables user to easily implement fraud detection feature into their solution using the API from www.fraudlabspro.com"
  s.homepage      = "https://github.com/fraudlabspro/fraudlabspro-ruby"
  s.licenses      = ["MIT"]
  s.require_paths = ["lib"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "fraudlabspro_ruby.gemspec",
    "lib/fraudlabspro_ruby.rb",
    "lib/fraudlabspro_ruby/api.rb",
    "lib/fraudlabspro_ruby/api/order.rb",
    "lib/fraudlabspro_ruby/api/smsverification.rb",
    "lib/fraudlabspro_ruby/configuration.rb",
    "lib/fraudlabspro_ruby/version.rb",
    "spec/spec_helper.rb",
    "spec/fraudlabspro_ruby_fraudvalidation_spec.rb",
    "spec/fraudlabspro_ruby_smsverification_spec.rb"
  ]
end