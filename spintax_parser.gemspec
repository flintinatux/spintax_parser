# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spintax_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Scott McCormack"]
  gem.email         = ["mail@madhackerdesigns.com"]
  gem.description   = %q{A mixin to parse "spintax", a text format used for automated article generation. Can handle nested spintax.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/flintinatux/spintax_parser"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "spintax_parser"
  gem.require_paths = ["lib"]
  gem.version       = SpintaxParser::VERSION

  gem.add_dependency 'backports'
  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'guard-rspec', '~> 1.2.1'
end
