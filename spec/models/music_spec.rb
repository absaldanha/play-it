RSpec.describe Music do
  describe '#new' do
    let(:path_example) { '/usr/example.mp3' }
    let(:features_example) { { foo: 5.4, bar: 2 } }

    context 'when some features are given' do
      subject { described_class.new(path_example, features_example) }

      it 'is an instance of Music' do
        is_expected.to be_a described_class
      end

      it 'have the path of the music' do
        expect(subject.path).to eq(path_example)
      end

      it 'have the features of the music' do
        expect(subject.features).to eq(features_example)
      end
    end

    context 'when no features are given' do
      subject { described_class.new(path_example) }

      it 'is an instance of Music' do
        expect(subject).to be_a described_class
      end

      it 'have the path of the music' do
        expect(subject.path).to eq(path_example)
      end

      it 'dont have features' do
        expect(subject.features).to be_empty
      end
    end
  end

  describe '#==' do
    let(:a_music) { Music.new('/usr/example.mp3', { foo: 5.2, bar: 3 }) }

    subject { a_music == other_music }

    context 'when two musics are equal' do
      let(:other_music) { Music.new('/usr/example.mp3', { foo: 4.2, bar: 1 }) }

      it { is_expected.to be_truthy }
    end

    context 'when too musics are not equal' do
      let(:other_music) { Music.new('/usr/other.mp3', { foo: 4.2, bar: 1 }) }

      it { is_expected.to be_falsy }
    end
  end
end
