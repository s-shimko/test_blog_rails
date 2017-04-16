# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :all do
  sh "cucumber -t @all"
end

task :run_tag, [:tag_name] do |t, args|
  sh "cucumber -t #{args.tag_name}"
end
