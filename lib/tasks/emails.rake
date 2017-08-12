namespace :emails do
  desc 'Receive emails via STDIN'
  task :receive => :environment do
    require 'emails/receive'
    Emails::Receive.new($stdin.read()).create()
  end

  desc 'Receive emails via an mbox file'
  task :load, [:file] => :environment do |t,args|
    require 'emails/receive'
    file = args[:file]

    #Copied from https://stackoverflow.com/questions/6012930/how-to-read-lines-of-a-file-in-ruby
    message = nil
    File.open(file).each do |line|
      if line.match(/\AFrom /)
        Emails::Receive.new(message).create() if (message)
        message = ''
      else
        message << line.sub(/^\>From/, 'From')
      end
    end
  end
end
