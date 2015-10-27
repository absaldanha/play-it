RSpec.describe PlayIt::Extraction::Parser do
  describe '.parse' do
    let(:unparsed_data) do
      {
        'lowlevel' => {
          'average_loudness' => 1.0,
          'dynamic_complexity' => 2.0,
          'spectral_centroid' => {
            'mean' => 3.0
          },
          'spectral_rms' => {
            'mean' => 4.0
          },
          'zerocrossingrate' => 5.0,
          'mfcc' => [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
          ],
          'something_else' => 'oi',
          'another_thing' => 'oi oi'
        },
        'rhythm' => {
          'beats_count' => 111,
          'beats_loudness' => {
            'mean' => 0.5
          },
          'bpm' => 222,
          'danceability' => 5,
          'other_thing' => 'a thing'
        },
        'hash' => {
          'value1' => 0,
          'value2' => 1
        }
      }
    end

    let(:parsed_data) do
      {
        average_loudness: 1.0,
        dynamic_complexity: 2.0,
        spectral_centroid: 3.0,
        spectral_rms: 4.0,
        zerocrossingrate: 5.0,
        mfcc_0: 0,
        mfcc_1: 1,
        mfcc_2: 2,
        mfcc_3: 3,
        mfcc_4: 4,
        mfcc_5: 5,
        mfcc_6: 6,
        mfcc_7: 7,
        mfcc_8: 8,
        mfcc_9: 9,
        mfcc_10: 10,
        mfcc_11: 11,
        mfcc_12: 12,
        mfcc_13: 13,
        beats_count: 111,
        beats_loudness: 0.5,
        bpm: 222,
        danceability: 5
      }
    end

    it 'parses the data' do
      expect(described_class.parse(unparsed_data)).to eq parsed_data
    end
  end
end
