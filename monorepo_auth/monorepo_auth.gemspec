Gem::Specification.new do |s|
  s.name        = 'monorepo_auth'
  s.version     = '1.0.0'
  s.date        = '2023-05-11'
  s.summary     = 'Summary'
  s.description = 'Description'
  s.authors     = ['Arthur Ferraz dos Santos']
  s.email       = 'arthur.santos@foxbit.com.br'
  s.files       = Dir['{lib}/**/*', 'README.md', 'monorepo_auth.gemspec']
  s.require_paths = ['lib']
  s.add_dependency 'activesupport'
  s.add_dependency 'httparty'
  s.add_dependency 'jwt'
  s.add_dependency 'santa_cruz'
end
