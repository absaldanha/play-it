##
# Class that manages the session events
class Logger

  ##
  # @return [Array] the list of events of the session
  attr_reader :session_events

  ##
  # Creates a Logger object, which will manage the list of events
  # of the session
  #
  # @return [Logger] the logger for the session
  def initialize
    @session_events = []
  end

  ##
  # Adds the new +event+ to the list
  #
  # @param event [Hash] the event to be added
  def log(event)
    return false unless event.is_a? Hash
    @session_events << event
  end
end
