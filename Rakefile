require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  # t.test_files = FileList['spec/lib/*_spec.rb']
  t.test_files = FileList['spec/lib/player_spec.rb']
  t.verbose = true
end

task default: :test
