require 'resque/tasks'
require 'emails/receive_job'

namespace :resque do
  task :setup => :environment
end
