Gem::Specification.new do |spec|
  spec.name        = 'zip-zip'
  spec.version     = '0.1'
  spec.date        = '2013-09-15'
  spec.summary     = 'Ease the migration to RubyZip v1.0.0'
  spec.description =
'''
In Gem hell migrating to RubyZip v1.0.0?
Include zip-zip in your Gemfile and everythings coming up roses!
'''
  spec.authors     = ['Orien Madgwick']
  spec.email       = 'orien.madgwick@gmail.com'
  spec.files       = ['lib/zip/zip.rb', 'lib/zip/zipfilesystem.rb']
  spec.homepage    = 'https://github.com/orien/zip-zip'
  spec.license     = 'MIT'
  spec.add_runtime_dependency 'rubyzip', '>= 1.0.0'
end
