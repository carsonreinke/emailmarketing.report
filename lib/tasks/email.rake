namespace :email do
  namespace :process do
    desc "Run daemon to process emails"
    task :daemon => :environment do
      require 'email/process_daemon'
      Email::ProcessDaemon.run()
    end
  end
  
  task :receive => :environment do
    require 'email/receive'
    Email::Receive.new($stdin.read()).create()
  end
end