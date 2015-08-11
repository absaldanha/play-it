##
# Class that represents a music
class Music
  include Comparable

  ##
  # @return [String] the path to the music in the OS
  attr_accessor :path

  ##
  # @return [Hash] the extracted features of the music
  attr_accessor :features

  ##
  # Creates a new music object with the given +path+ and +features+
  #
  # @param path [String] the path to the music in the OS
  # @param features [Hash] the set of features of the music
  #
  # @return [Music] the object representing the music
  def initialize(path, features = nil)
    @path = path
    @features = features || {}
  end

  ##
  # Equality - Two musics are equal if they contain the same path
  #
  # @return [bool] true if a music is equal another music, false otherwise
  def ==(other)
    @path == other.path
  end
end
