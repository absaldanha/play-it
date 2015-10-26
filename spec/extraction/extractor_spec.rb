RSpec.describe PlayIt::Extraction::Extractor do
  let(:feature_list) { PlayIt::Extraction::Extractor::FEATURE_LIST }

  describe '.extract_features' do
    let(:music_path) { File.expand_path("./../../fixtures/sample.mp3", __FILE__) }

    it 'extracts the features' do
      described_class.extract_features(music_path).each do |key, value|
        expect(feature_list).to include(key)
        expect(value).to match /\d+\.\d+/
      end
    end
  end
end
