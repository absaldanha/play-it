task default: :cop

task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
end

task cop: :spec do
  ENV['COVERAGE'] = 'true'

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  tasks = []
  tasks << 'rubocop:auto_correct'

  tasks.each do |task|
    Rake::Task[task].invoke
  end
end
