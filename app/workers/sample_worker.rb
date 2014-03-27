class SampleWorker
  @queue = :sample_worker
  def self.perform
    puts "worker running"
  end
end