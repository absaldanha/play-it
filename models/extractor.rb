require 'tempfile'
require 'cocaine'

class ExtractionError < StandardError; end

##
# Extracts features from a music file.
class Extractor
  ##
  # List of features to initialize the Extractor.
  FEATURE_LIST = [
    # lowlevel
    'average_loudness',
    'dynamic_complexity',

    # rhythm
    'beats_count',
    'bpm',
    'danceability',
    'onset_rate',

    # tonal
    'chords_changes_rate',
    'chords_number_rate',
    'key_strength',
    'tuning_diatonic_strength',
    'tuning_equal_tempered_deviation',
    'tuning_frequency',
    'tuning_nontempered_energy_ratio'
  ]

  def initialize
    @feature_list = FEATURE_LIST
  end

  ##
  # Extracts features from a music file located in +path+.
  #
  # @param path [String] Path of the music file.
  #
  # @return [Hash] Hash of features for the music, in the form
  #                feature_name => extracted_value
  #
  def extract(path)
    output = run(path)

    parse(output)
  end

  private

  def run(path)
    Tempfile.open(['tmp', '.json'], 'tmp') do |tmp|
      line = command(path, tmp.path)

      begin
        line.run
      rescue => ex
        raise ExtractionError,
              "Failed to execute extractor binary with error: #{ex.message}."
      end

      tmp.rewind
      tmp.read
    end
  end

  def command(src_path, dst_path)
    Cocaine::CommandLine.path = File.expand_path("#{__FILE__}/../../bin")
    line = Cocaine::CommandLine.new(
      "streaming_extractor_music #{src_path} #{dst_path}"
    )
    line
  end

  def parse(output)
    output = JSON.parse(output)
    output.inject({}) do |result, (_, feature_hash)|
      result.merge(
        feature_hash.select { |key, _| @feature_list.include?(key) }
      )
    end
  end
end
