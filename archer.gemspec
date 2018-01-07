Gem::Specification.new do |s|
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/*`.split("\n")
  s.name        = 'archer'
  s.summary     = 'Telegram bot framework.'
  s.version     = '0.0.1'
  s.author      = 'Just Me @just806me'
  s.email       = 'just806me@gmail.com'
  s.homepage    = 'https://github.com/just806me/archer'
  s.license     = 'MIT'
  s.executables << 'archer'

  s.add_dependency 'activesupport'
end
