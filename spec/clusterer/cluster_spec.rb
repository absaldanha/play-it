RSpec.describe PlayIt::Clusterer::Cluster do
  describe '.new' do
    let(:a_music) do
      double(
        "music_1",
        label: 'music1_instance',
        centroid_distance: 2.5
      )
    end
    let(:another_music) do
      double(
        "music_2",
        label: 'music2_instance',
        centroid_distance: 1.2
      )
    end

    let(:music) { [a_music, another_music] }

    before do
      expect(a_music).to receive(:label)
      expect(another_music).to receive(:label)

      expect(a_music).to receive(:centroid_distance)
      expect(another_music).to receive(:centroid_distance)
    end

    it 'contains an array of music' do
      cluster = described_class.new music
      expect(cluster.music).to match_array ['music1_instance', 'music2_instance']
    end

    it 'calculates the radius of the cluster' do
      cluster = described_class.new music
      expect(cluster.radius).to eq 2.5
    end
  end
end
