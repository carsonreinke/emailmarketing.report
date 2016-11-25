namespace :emails do
  task :receive => :environment do
    require 'emails/receive'
    Emails::Receive.new($stdin.read()).create()
  end
end