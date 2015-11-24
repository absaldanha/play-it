RSpec.describe PlayIt::Recommender do
  describe '#recommend' do
    let(:cluster_set) do
      double(
        'cluster_set',
        size: 3,
        :[] => cluster
      )
    end

    let(:cluster) do
      double(
        'cluster',
        ring: [PlayIt::Music.new('/usr/example.mp3')]
      )
    end

    subject { described_class.new cluster_set }

    context 'when the last music was accepted' do
      it 'recommends a new music' do
        expect(subject.recommend(:accepted)).to be_a PlayIt::Music
      end
    end

    context 'when the last music as skipped' do
      it 'recommends a new music' do
        expect(subject.recommend(:skip)).to be_a PlayIt::Music
      end
    end
  end
end
