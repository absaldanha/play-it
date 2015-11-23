RSpec.describe PlayIt::Clusterer::ClusterSet do
  let(:cluster) do
    double "cluster1", is_a?: PlayIt::Clusterer::Cluster
  end

  let(:another_cluster) do
    double "cluster2", is_a?: PlayIt::Clusterer::Cluster
  end

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

  describe '#cluster' do
    before do
      subject.add(cluster)
      subject.add(another_cluster)
    end

    context 'when a cluster exists at the index' do
      it 'returns the right cluster' do
        expect(subject.cluster(1)).to eq another_cluster
      end
    end

    context 'when no cluster exists at the index' do
      it { expect(subject.cluster(2)).to be_falsy }
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
