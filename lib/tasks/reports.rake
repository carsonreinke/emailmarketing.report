namespace :reports do
  desc 'Queue a report for all emails'
  task :queue, [:klass] => :environment do |t,args|
    require 'reports'
    klass = args[:klass].constantize()

    Email.find_each do |email|
      ReportJob.perform_later(klass.name, email.id)
    end
  end
end
