module PlayIt
  module Extraction
    class Parser
      LOWLEVEL_FEATURES = [
        :average_loudness,
        :dynamic_complexity,
        :spectral_centroid,
        :spectral_rms,
        :zerocrossingrate,
        :mfcc
      ]

      RHYTHM_FEATURES = [
        :beats_count,
        :beats_loudness,
        :bpm,
        :danceability
      ]

      class << self
        def parse(data)
          lowlevel(data['lowlevel']).merge rhythm(data['rhythm'])
        end

        private

        def lowlevel(data)
          hash = data.select { |key, _| LOWLEVEL_FEATURES.include? key }

          {
            average_loudness: data['average_loudness'],
            dynamic_complexity: data['dynamic_complexity'],
            spectral_centroid: data['spectral_centroid']['mean'],
            zerocrossingrate: data['zerocrossingrate'],
            spectral_rms: data['spectral_rms']['mean'],
            mfcc_0: data['mfcc'][0],
            mfcc_1: data['mfcc'][1],
            mfcc_3: data['mfcc'][3],
            mfcc_4: data['mfcc'][4],
            mfcc_5: data['mfcc'][5],
            mfcc_6: data['mfcc'][6],
            mfcc_7: data['mfcc'][7],
            mfcc_8: data['mfcc'][8],
            mfcc_9: data['mfcc'][9],
            mfcc_10: data['mfcc'][10],
            mfcc_11: data['mfcc'][11],
            mfcc_12: data['mfcc'][12],
            mfcc_13: data['mfcc'][13],
          }
        end

        def rhythm(data)
          {
            beats_count: data['beats_count'],
            beats_loudness: data['beats_loudness']['mean'],
            bpm: data['bpm'],
            danceability: data['danceability']
          }
        end
      end
    end
  end
end
