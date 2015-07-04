##
# Class that represents a music
class Music
  ##
  # Describes the path to the music in the OS
  attr_accessor :path

  ##
  # Describes the extracted features of the music
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
end
