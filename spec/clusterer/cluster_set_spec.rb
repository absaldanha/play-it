RSpec.describe PlayIt::Clusterer::ClusterSet do
  let(:cluster) { PlayIt::Clusterer::Cluster.new }
  let(:another_cluster) { PlayIt::Clusterer::Cluster.new }

  describe '#add' do
    context 'when the object is a Cluster' do
      before { subject.add(cluster) }

      it 'adds the cluster' do
        expect(subject.clusters).to include cluster
      end
    end

    context 'when the object is not a Cluster' do
      it 'fails to add the object' do
        expect do
          subject.add('fail')
        end.to raise_error ArgumentError
      end
    end
  end

  describe '#get_cluster' do
    before do
      subject.add(cluster)
      subject.add(another_cluster)
    end

    context 'when a cluster exists at the index' do
      it 'returns the right cluster' do
        expect(subject.get_cluster(1)).to be_a PlayIt::Clusterer::Cluster
      end
    end

    context 'when no cluster exists at the index' do
      it { expect(subject.get_cluster(2)).to be_falsy }
    end
  end

  describe '#size' do
    before do
      subject.add(cluster)
      subject.add(another_cluster)
    end

    it 'returns the number of clusters' do
      expect(subject.size).to eq 2
    end
  end
end
