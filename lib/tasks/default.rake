# frozen_string_literal: true

if Rails.env.test? || Rails.env.development?
  require "rubocop/rake_task"
  require "bundler/audit/task"

  RuboCop::RakeTask.new
  Bundler::Audit::Task.new

  dir = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

  desc "Run Brakeman"
  task :brakeman do
    puts `#{File.join(dir, "bin", "brakeman")} #{File.join(dir, ".")}`
  end

  task :default do
    Rake::Task["rubocop"].invoke
    Rake::Task["brakeman"].invoke
    Rake::Task["spec"].invoke
    Rake::Task["bundle:audit"].invoke
  end
end
