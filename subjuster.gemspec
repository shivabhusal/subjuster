# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "subjuster/version"

Gem::Specification.new do |spec|
  spec.name          = "subjuster"
  spec.version       = Subjuster::VERSION
  spec.authors       = ["Shiva Bhusal"]
  spec.email         = ["hotline.shiva@gmail.com"]

  spec.summary       = %q{Subjuster | TDD guide for Software Engineers in OOP}
  spec.description   = %q{A command line tool to adjust your movie subtitle files while while playing audio and subtitle do not sync with each other. Normally it lags/gains by a few seconds/milliseconds. You will be able to adjust and generate a new subtitle file or update the existing one.}
  spec.homepage      = "http://subjuster.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|images)/})
  end
  
  # Since we intend to make it a CLI tool, need to have executable script
  # Create a new dir `exe` and put `subjuster`
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
