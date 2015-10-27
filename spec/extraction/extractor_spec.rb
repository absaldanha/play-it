RSpec.describe PlayIt::Extraction::Extractor do
  let(:feature_list) do
    [
      :average_loudness, :dynamic_complexity, :spectral_centroid, :spectral_rms, :zerocrossingrate,
      :mfcc_0, :mfcc_1, :mfcc_2, :mfcc_3, :mfcc_4, :mfcc_5, :mfcc_6, :mfcc_7, :mfcc_8, :mfcc_9,
      :mfcc_10, :mfcc_11, :mfcc_12, :mfcc_13, :beats_count, :beats_loudness, :bpm, :danceability
    ]
  end

  describe '.extract_features' do
    let(:music_path) { File.expand_path("./../../fixtures/sample2.mp3", __FILE__) }

    before do
      allow(PlayIt::Extraction::Parser).to receive(:parse).and_return()
    end

    it 'extracts the features' do
      described_class.extract_features(music_path).each do |key, value|
        expect(feature_list).to include(key)
        expect(value).to match /\d+\.\d+/
      end
    end
  end
end
