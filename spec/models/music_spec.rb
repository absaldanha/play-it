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
end
