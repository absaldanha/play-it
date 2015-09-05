RSpec.describe PlayIt::Music do
  describe '#path' do
    let(:path) { '/usr/example.mp3' }

    subject { described_class.new(path) }

    its(:path) { is_expected.to eq path }
  end

  describe '#features' do
    let(:path) { '/usr/example.mp3' }
    let(:features) { { foo: 5.4, bar: 2 } }

    context 'when some features are given' do
      subject { described_class.new(path, features) }

      its(:features) { are_expected.to eq features }
    end

    context 'when no features are given' do
      subject { described_class.new(path) }

      its(:features) { are_expected.to eq({}) }
    end
  end

  describe '#==' do
    let(:path) { '/usr/example.mp3' }
    let(:another_path) { '/usr/other.mp3' }

    let(:features) { { foo: 5.2, bar: 3 } }
    let(:other_features) { { foo: 4.2, bar: 1 } }

    let(:a_music) { described_class.new(path, features) }

    subject { a_music == another_music }

    context 'when musics are equal' do
      let(:another_music) { described_class.new(path, other_features) }

      it { is_expected.to be_truthy }
    end

    context 'when musics are not equal' do
      let(:another_music) { described_class.new(another_path, other_features) }

      it { is_expected.to be_falsy }
    end
  end
end
