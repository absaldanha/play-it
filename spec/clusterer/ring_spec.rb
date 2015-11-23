RSpec.describe PlayIt::Clusterer::Ring do
  describe '<<' do
    let(:music) { PlayIt::Music.new '/usr/example.mp3' }

    before { subject << music }

    it 'adds the music' do
      expect(subject.music).to include music
    end
  end
end
