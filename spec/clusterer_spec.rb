RSpec.describe PlayIt::Clusterer do
  describe '.make_clusters' do
    let(:a_music) do
      PlayIt::Music.new('/usr/example.mp3', foo: 5.4, bar: 3.2)
    end

    let(:another_music) do
      PlayIt::Music.new('/usr/other.mp3', foo: 2, bar: 5.1)
    end

    let(:music_set) do
      Set.new [a_music, another_music]
    end

    it 'makes the clusters' do
      expect(described_class.make_clusters(music_set))
        .to be_a PlayIt::Clusterer::ClusterSet
    end
  end
end
