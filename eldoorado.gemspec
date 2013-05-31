lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eldoorado/version'

Gem::Specification.new do |gem|
  gem.name          = "eldoorado"
  gem.version       = Eldoorado::VERSION
  gem.authors       = ["Geoff Schorkopf"]
  gem.email         = ["gschorkopf@gmail.com"]
  gem.description   = %q{Ruby wrapper gem for Eldoorado API}
  gem.summary       = %q{Ruby wrapper gem for Eldoorado API}
  gem.homepage      = "http://rubygems.org/gems/eldoorado_gem"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end