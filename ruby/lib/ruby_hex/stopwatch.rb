class Stopwatch
  def start
    @start = Time.now
    self
  end

  def stop
    elapsed = (Time.now - @start).round
    ::ChronicDuration.output(elapsed, format: :short, keep_zero: true)
  end
end
