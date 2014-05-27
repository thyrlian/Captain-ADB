module CaptainADB
  class IoStream
    class << self
      def redirect_command_output(cmd, &blk)
        begin
          output = IO.popen(cmd)
          while (line = output.gets)
            blk.call(line)
          end
        rescue Exception => e
          puts e.message
          puts e.backtrace.inspect
        end
      end
  
      def log_command_output_and_error(cmd)
        begin
          stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
          out, err = '', ''
          stdout.each_line {|line| out += line}
          stderr.each_line {|line| err += line}
          exit_status = wait_thr.value
          if exit_status.success?
            result = [true, {out: out, err: err}]
          else
            if exit_status.signaled?
              termsig = exit_status.termsig
              termsig = "Null" if termsig.nil?
              result = [false, {out: out, err: "Terminated because of an uncaught signal: #{termsig}"}]
            else
              result = [false, {out: out, err: err}]
            end
          end
        rescue Exception => e
          puts e.message
          puts e.backtrace.inspect
        ensure
          [stdin, stdout, stderr].each {|io| io.close}
        end
        result
      end
    end
    
    private_class_method :new
  end
end