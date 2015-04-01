# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spotlight/ldpath/version'

Gem::Specification.new do |spec|
  spec.name          = "spotlight-ldpath"
  spec.version       = Spotlight::Ldpath::VERSION
  spec.authors       = ["Chris Beer"]
  spec.email         = ["cabeer@stanford.edu"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "blacklight-spotlight"
  spec.add_dependency "linkeddata"
  spec.add_dependency "ldpath"
  spec.add_dependency "rails"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
