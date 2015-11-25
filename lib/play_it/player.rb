# :nocov:

require 'forwardable'
require 'play_it/player/streamer'
require 'play_it/player/view'
require 'play_it/player/controller'

module PlayIt
  module Player
    def self.run
      controller = Controller.new
      controller.run
    end
  end
end
