module PlayIt
  module Extraction
    class Parser
      LOWLEVEL_FEATURES = %w(dynamic_complexity spectral_centroid spectral_rms zerocrossingrate)

      RHYTHM_FEATURES = %w(bpm danceability)

      class << self
        ##
        # Parses the JSON returned from the extraction.
        #
        # @param data [String] JSON data.
        #
        # @return [Hash] Features hash.
        #
        def parse(data)
          features = parse_lowlevel(data['lowlevel']).merge parse_rhythm(data['rhythm'])
          symbolize_keys(features)
        end

        private

        def parse_lowlevel(data)
          parse_mfcc(data['mfcc']['mean']).merge features(data, LOWLEVEL_FEATURES)
        end

        def parse_rhythm(data)
          features(data, RHYTHM_FEATURES)
        end

        def parse_mfcc(data)
          (0..12).each_with_object({}) do |i, hash|
            hash["mfcc_#{i}"] = data[i]
          end
        end

        def features(data, feature_list)
          data.keep_if { |key, _| feature_list.include? key }

          data.each_with_object({}) do |(key, value), features|
            mean_key?(value) ? features[key] = value['mean'] : features[key] = value
          end
        end

        def mean_key?(value)
          value.respond_to?(:key?) && value.key?('mean')
        end

        def symbolize_keys(hash)
          Hash[hash.map { |key, value| [key.to_sym, value] }]
        end
      end
    end
  end
end
