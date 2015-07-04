##
# Class that represents a music

class Music

  attr_accessor :path
  attr_accessor :features

  ##
  # Creates a new music object with the given +path+ and +features+

  def initialize(path, features = nil)
    @path = path
    @features = features.nil? ? {} : features
  end

end