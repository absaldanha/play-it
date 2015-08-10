RSpec.describe Library do
  subject(:library) { described_class.new }

  describe '#new' do
    context 'when an object is instantiate' do
      it 'is an instance of Library' do
        is_expected.to be_a described_class
      end

      it 'creates an empty array os Musics' do
        expect(library.musics).to be_empty
      end
    end
  end

  describe '#load', fakefs: true do
    context 'when the file exists' do
      let(:loaded_musics) do
        [
          Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }),
          Music.new('/usr/example2.mp3', { foo: 4.4, bar: 1 })
        ]
      end

      before do
        File.open(described_class::FILE_PATH, 'wb') do |file| 
          file.write(Marshal.dump(loaded_musics))
        end

        library.load
      end

      it 'it loads the musics and features' do
        expect(library.musics).not_to be_empty
      end
    end

    context 'when the file doesnt exist' do
      it 'creates an empty file' do
        library.load
        expect(File.exist?(described_class::FILE_PATH)).to be_truthy
        expect(File.zero?(described_class::FILE_PATH)).to be_truthy
      end

      it "doesn't load any music" do
        library.load
        expect(library.musics).to be_empty
      end
    end
  end

  describe '#dump' do
    let(:musics) do
      [
          Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }),
          Music.new('/usr/example2.mp3', { foo: 4.4, bar: 1 })
      ]
    end

    before do
      library.musics = musics
    end

    it 'saves the file' do
      library.dump
      expect(File.exist?(described_class::FILE_PATH)).to be_truthy
      expect(File.size(described_class::FILE_PATH)).to be > 0
    end
  end

  describe '#add' do
    context 'when a valid music is given' do
      let(:valid_music) { Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }) }

      it 'adds the music to the library' do
        library.add(valid_music)
        expect(library.musics).to include valid_music
      end
    end

    context 'when a duplicate is given' do
      let(:music) { Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }) }

      before { library.add(music) }

      it "doesn't add to the library" do
        expect(library.add(music)).to be_falsy
      end
    end

    context 'when it is not a music' do
      it "doesn't add to the library" do
        expect(library.add('something')).to be_falsy
      end
    end
  end

  describe '#remove' do
    let(:music) { Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }) }

    context 'when the music exists in the library' do
      before { library.add(music) }

      it 'removes the music of the library' do
        library.remove(music.path)
        expect(library.musics).not_to include music
      end
    end

    context "when the music doesn't exist in the library" do
      it 'does nothing' do
        expect {
          library.remove(music.path)
        }.not_to change{ library.musics.size }
      end
    end
  end
end