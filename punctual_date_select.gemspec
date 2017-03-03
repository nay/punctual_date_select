# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'punctual_date_select/version'

Gem::Specification.new do |spec|
  spec.name          = "punctual_date_select"
  spec.version       = PunctualDateSelect::VERSION
  spec.authors       = ["nay3"]
  spec.email         = ["y.ohba@everyleaf.com"]

  spec.summary       = %q{It provides similar feature like date_select but it won't cast invalid dates.}
  spec.description   = %q{It provides similar feature like date_select but it won't cast invalid dates.}
  spec.homepage      = "https://github.com/nay/punctual_date_select"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
