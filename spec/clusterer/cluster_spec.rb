RSpec.describe PlayIt::Clusterer::Cluster do
  describe '#add' do
    let(:music) { PlayIt::Music.new('/usr/example.mp3') }

    before { subject.add(music) }

    it 'adds the music' do
      expect(subject.music).to include music
    end
  end
end
