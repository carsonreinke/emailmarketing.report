module Charts
end

Dir[File.join(File.dirname(__FILE__), 'charts', '*.rb')].each {|file| require file }
