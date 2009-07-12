gem 'sr-mg', '0.0.3'
require "mg"
MG.new("fancypath.gemspec")

require 'spec/rake/spectask'
desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end

task :default => :spec