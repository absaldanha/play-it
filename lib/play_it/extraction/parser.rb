module PlayIt
  module Extraction
    class Parser
      LOWLEVEL_FEATURES = [
        'average_loudness',
        'dynamic_complexity',
        'spectral_centroid',
        'spectral_rms',
        'zerocrossingrate',
        'mfcc'
      ]

      RHYTHM_FEATURES = [
        'beats_count',
        'beats_loudness',
        'bpm',
        'danceability'
      ]

      class << self
        def parse(data)
          lowlevel(data['lowlevel']).merge rhythm(data['rhythm'])
        end

        private

        def lowlevel(data)
          {
            average_loudness: data['average_loudness'],
            dynamic_complexity: data['dynamic_complexity'],
            spectral_centroid: data['spectral_centroid']['mean'],
            zerocrossingrate: data['zerocrossingrate'],
            spectral_rms: data['spectral_rms']['mean']
          }.merge mfcc(data['mfcc'])
        end

        def mfcc(data)
        {
          mfcc_0: data[0],
          mfcc_1: data[1],
          mfcc_2: data[2],
          mfcc_3: data[3],
          mfcc_4: data[4],
          mfcc_5: data[5],
          mfcc_6: data[6],
          mfcc_7: data[7],
          mfcc_8: data[8],
          mfcc_9: data[9],
          mfcc_10: data[10],
          mfcc_11: data[11],
          mfcc_12: data[12],
          mfcc_13: data[13],
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
