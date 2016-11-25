require 'email/process'

module Email
  class ProcessDaemon
    ERROR_DELAY = 5.seconds

    class << self
      def run()
        while true
          begin
            Email::Report.new(
              Email::Process.new().create()
            ).create()
          rescue
            $stderr.puts($!.message)
            $stderr.puts($!.backtrace.join("\n"))

            $stderr.puts("Waiting for #{ERROR_DELAY.inspect} after error...")
            sleep ERROR_DELAY.to_i()
          end
        end
      end
    end
  end
end