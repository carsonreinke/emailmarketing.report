require 'resque/tasks'
require 'emails/process_job'

namespace :resque do
  task :setup => :environment
end