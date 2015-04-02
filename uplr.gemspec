# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uplr/version'

Gem::Specification.new do |spec|
  spec.name          = "uplr"
  spec.version       = Uplr::VERSION
  spec.authors       = ["Eric Teubert"]
  spec.email         = ["eric@ericteubert.de"]
  spec.summary       = %q{Uploads Files via SSH to your own server and copies the resulting URL to clipboard for easy sharing.}
  spec.description   = %q{Uploads the specified file to the given server. Progress is shown via system notifications (disable with --no-progress). The final notification is clickable and opens the share URL in a web browser. The share URL is automatically copied to the system clipboard (disable with --no-clipboard).}
  spec.homepage      = "https://github.com/eteubert/uplr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
