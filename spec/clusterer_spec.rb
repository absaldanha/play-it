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
      expect(described_class.make_clusters(music_set, 1, 10))
        .to be_a PlayIt::Clusterer::ClusterSet
    end
  end

  describe '.load' do
    let(:cluster_set) { double 'cluster_set', load: true }

    before do
      expect(PlayIt::Clusterer::ClusterSet).to receive(:new).and_return(cluster_set)
      expect(cluster_set).to receive(:load)
    end

    it 'loads the cluster set' do
      expect(subject.load).to eq cluster_set
    end
  end
end
