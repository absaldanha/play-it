RSpec.describe PlayIt::Library do
  describe '#dump_path' do
    let(:path) { 'library.dat' }

    before do
      allow(PlayIt::Configuration).to receive(:library_path).and_return(path)
    end

    it 'sets path according to configuration' do
      expect(subject.dump_path).to eq path
    end
  end

  describe '#load' do
    context 'when the file exists' do
      let(:loaded_music) do
        [
          PlayIt::Music.new('/usr/example.mp3', foo: 5.2, bar: 3),
          PlayIt::Music.new('/usr/example2.mp3', foo: 4.4, bar: 1)
        ]
      end

      before do
        File.open(subject.dump_path, 'wb') do |file|
          file.write(Marshal.dump(loaded_music))
        end

        subject.load
      end

      it 'loads the music' do
        expect(subject.music).to eq loaded_music
      end
    end
  end

  describe '#dump' do
    let(:music) do
      [
        PlayIt::Music.new('/usr/example.mp3', foo: 5.2, bar: 3),
        PlayIt::Music.new('/usr/example2.mp3', foo: 4.4, bar: 1)
      ]
    end

    let(:dump) { Marshal.dump(music) }

    before do
      subject.music = music
      subject.dump
    end

    it 'dumps the music' do
      expect(File.read(subject.dump_path)).to eq dump
    end
  end

  describe '#add' do
    context 'when a new music is given' do
      let(:valid_music) do
        PlayIt::Music.new('/usr/example.mp3', foo: 5.2, bar: 3)
      end

      before { subject.add(valid_music) }

      it 'adds the music' do
        expect(subject.music).to include valid_music
      end
    end

    context 'when a duplicate is given' do
      let(:music) do
        PlayIt::Music.new('/usr/example.mp3', foo: 5.2, bar: 3)
      end

      before { subject.add(music) }

      it { expect { subject.add(music) }.not_to change { subject.music } }
    end
  end

  describe '#remove' do
    let(:music) { PlayIt::Music.new('/usr/example.mp3', foo: 5.2, bar: 3) }

    context 'when the music exists in the library' do
      before { subject.add(music) }

      it 'removes the music' do
        expect { subject.remove(music.path) }.to change { subject.music }
          .from(a_collection_containing_exactly(music))
          .to(be_empty)
      end
    end

    context "when the music doesn't exist in the library" do
      it do
        expect { subject.remove(music.path) }.not_to change { subject.music }
      end
    end
  end

  describe '#sample' do
    let(:music1) { double 'music' }
    let(:music2) { double 'music' }

    before { subject.music = [music1, music2] }

    it 'returns a random music' do
      expect(subject.sample).to eq(music1).or eq(music2)
    end
  end
end
