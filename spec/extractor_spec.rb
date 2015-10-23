RSpec.describe PlayIt::Extractor do
  describe '.extract' do
    let(:music) { '/home/examples/sample.mp3' }

    let(:music_features) { { foo: 1.0, bar: 50.2 } }

    before do
      expect(PlayIt::Extractor::Extract).to receive(:extract_features)
        .with(music).and_return(music_features)
    end

    it 'extracts the features' do
      expect(described_class.extract(music)).to include music_features
    end
  end
end
