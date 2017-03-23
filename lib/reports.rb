module Reports
end

Dir[File.join(File.dirname(__FILE__), 'reports', '*.rb')].each {|file| require file }
