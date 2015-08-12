##
# Class that manages the session events
class Logger

  ##
  # @return [Array] the list of events of the session
  attr_reader :events

  ##
  # Creates a Logger object, which will manage the list of events
  # of the session
  #
  # @return [Logger] the logger for the session
  def initialize
    @events = []
  end

  ##
  # Adds the new +event+ to the list
  #
  # @param event [Hash] the event to be added
  def log(event)
    return false unless event.is_a? Hash
    @events << event
  end
end
