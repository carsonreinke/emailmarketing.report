require 'resque-history'

ActiveJob::QueueAdapters::ResqueAdapter::JobWrapper.class_eval do
  extend Resque::Plugins::History
end
