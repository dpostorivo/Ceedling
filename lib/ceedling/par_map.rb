

def par_map(n, things, &block)
  queue = Queue.new
  things.each { |thing| queue << thing }
  threads = (1..n).collect do
    Thread.new do
      Thread.current.report_on_exception = false
      Thread.abort_on_exception = true
      begin
        until queue.empty?
          yield queue.pop(true)
        end
      rescue => e
        puts e.message
        puts e.backtrace
        raise e
      end
    end
  end
  threads.each { |t| t.join }
end

