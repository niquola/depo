require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the dojo_on_rails plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  #t.pattern = 'test/*_test.rb'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc 'Generate documentation for the dojo_on_rails plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'depo'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_FILES = FileList[ '[a-zA-Z]*', 'generators/**/*', 'lib/**/*', 'rails/**/*', 'tasks/**/*', 'test/**/*' ]

require 'lib/depo.rb'
spec = Gem::Specification.new do |s|
  s.name = "depo"
  s.version = Depo::VERSION
  s.author = "niquola, smecsia"
  s.email = "niquola@gmail.com"
  #s.homepage = ""
  s.platform = Gem::Platform::RUBY
  s.summary = "Rails & Dojo integration"
  s.add_dependency('dojo_src')
  s.add_dependency('rails', '>= 2.3.5')
  s.add_dependency('kung_figure', '0.0.2')
  s.files = PKG_FILES.to_a 
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.rdoc"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
