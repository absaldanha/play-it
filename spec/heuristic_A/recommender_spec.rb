RSpec.describe PlayIt::Heuristic_A::Recommender do
  let(:music_seed) do
    PlayIt::Music.new 'example3.mp3', { foo: 0.5, bar: 0.5 }
  end

  let(:music) do
    PlayIt::Music.new 'example.mp3', { foo: 20, bar: 20 }
  end

  let(:another_music) do
    PlayIt::Music.new 'example2.mp3', { foo: 0.7, bar: 0.7 }
  end

  let(:music_set) do
    [
      music,
      another_music,
      music_seed
    ]
  end

  describe '.new' do
    it 'orders the music' do
      recommender = described_class.new music_set, music_seed
      expect(recommender.list).to eq [music_seed, another_music, music]
    end
  end

  describe '#recommend' do
    it 'recommends a music' do
      recommender = described_class.new music_set, music_seed
      expect(recommender.recommend).to be_a PlayIt::Music
    end
  end
end
