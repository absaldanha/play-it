class Logger
  attr_reader :session_events

  def initialize
    @session_events = []
  end

  def log(event)
    return false unless event.is_a? Hash
    @session_events << event
  end
end
