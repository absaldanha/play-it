RSpec.describe PlayIt::Extraction::Extractor do
  describe '.extract_features' do
    context 'when a valid music path is given' do
      let(:music_path) { File.expand_path('./../../fixtures/sample2.mp3', __FILE__) }
      let(:parsed_data) { symbolize_keys(load_json_sample('parsed_data.json')) }

      before do
        allow(PlayIt::Extraction::Parser).to receive(:parse).and_return(parsed_data)
      end

      it 'extracts the features' do
        expect(described_class.extract_features(music_path)).to include parsed_data
      end
    end

    context 'when an invalid music path is given' do
      let(:invalid_music_path) { 'foo/bar.mp3' }

      it 'raises an error' do
        expect {
          described_class.extract_features(invalid_music_path)
        }.to raise_error PlayIt::Extraction::Extractor::ExtractionError
      end
    end
  end
end
