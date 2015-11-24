require 'set'

module PlayIt
  class Music
    include Comparable

    attr_reader :path
    attr_accessor :features

    ##
    # Initializes the new music object with the given +path+ and +features+.
    #
    # @param path [String] the path to the music in the File System.
    # @param features [Hash] the set of features of this music.
    #
    def initialize(path, features = nil)
      @path = path
      @features = features || {}
    end

    ##
    # Equality - Two songs are equal if they have the same path.
    #
    # @return [bool] true if a music is equal to another music, false otherwise.
    #
    def ==(other)
      @path == other.path
    end
  end
end
