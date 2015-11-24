require 'tempfile'
require 'shellwords'
require 'play_it/extraction/extractor'
require 'play_it/extraction/parser'
require 'play_it/extraction/controller'

module PlayIt
  module Extraction
    ##
    # Set the delegate for the extracion.
    #
    # @param delegate [Object] object that will receive notifications of extraction events.
    # This object has to respond to :extraction_queue_size_changed and :extraction_finished.
    #
    def self.delegate=(delegate)
      controller.delegate = delegate
    end

    ##
    # Start the extraction of the enqueued songs.
    #
    def self.start
      controller.start
    end

    ##
    # Push a song to have its features extracted.
    # Call +start+ after enqueueing songs to start extraction.
    # You may enqueue more songs while the extraction is running.
    #
    # @param music [Music] music to extract features from.
    #
    def self.push(music)
      controller.push(music)
    end

    def self.controller
      @controller ||= Controller.new
    end
  end
end
