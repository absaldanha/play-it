module PlayIt
  ##
  # Class to log the events.
  #
  class Logger
    attr_reader :events

    def initialize
      @events = []
    end

    ##
    # Adds the new +event+ to the list.
    #
    # @param event [Hash] the event to be added.
    #
    def log(event)
      @events << event
    end
  end
end
