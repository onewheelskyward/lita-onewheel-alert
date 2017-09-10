Gem::Specification.new do |spec|
  spec.name          = 'lita-onewheel-alert'
  spec.version       = '0.0.0'
  spec.authors       = ['Andrew Kreps']
  spec.email         = ['andrew.kreps@gmail.com']
  spec.description   = %q{Lita interface to alert}
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/onewheelskyward/lita-onewheel-alert'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '~> 4'
  spec.add_runtime_dependency 'rest-client', '~> 1.8'
  # Old 'n busted
  # spec.add_runtime_dependency 'twilio-ruby', '~> 5'

  spec.add_development_dependency 'bundler', '~> 1'

  spec.add_development_dependency 'rake', '~> 11'
  spec.add_development_dependency 'rack-test', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency 'coveralls', '~> 0'
  spec.add_development_dependency 'twilio_mock', '~> 0'
end
