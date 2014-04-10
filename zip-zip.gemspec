# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'zip-zip'
  spec.version     = 0.3
  spec.summary     = 'Ease the migration to RubyZip v1.0.0'
  spec.description =
'''
In Gem hell migrating to RubyZip v1.0.0?
Include zip-zip in your Gemfile and everything\'s coming up roses!
'''
  spec.authors       = ['Orien Madgwick']
  spec.email         = '_@orien.io'
  spec.files         = ['lib/zip/zip.rb', 'lib/zip/zipfilesystem.rb', 'LICENSE.txt']
  spec.homepage      = 'https://github.com/orien/zip-zip'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']


  spec.add_runtime_dependency 'rubyzip', '>= 1.0.0'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '4.7.5'
  spec.add_development_dependency 'pry'
end
