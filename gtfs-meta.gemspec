# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtfs/meta/version'

Gem::Specification.new do |spec|
  spec.name          = "gtfs-meta"
  spec.version       = GTFS::Meta::VERSION
  spec.authors       = ["MJ Rossetti"]
  spec.email         = ["s2t2mail@gmail.com"]
  spec.summary       = %q{A GTFS data and metadata manager for ActiveRecord.}
  spec.description   = %q{Extracts feed data, manages feed versions, and extends the feed specification to include feed metadata.}
  spec.homepage      = "http::github.com/databyday/gtfs-meta"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rubyzip", "> 1.0"
  #spec.add_dependency "gtfs", "~> 0.2.3" # temporary rubyzip version conflict ...
end
