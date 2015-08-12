RSpec.describe Logger do
  subject(:logger) { described_class.new }

  describe '#new' do
    context 'when an logger is instantiate' do
      it 'is an instance of Logger' do
        is_expected.to be_a described_class
      end

      it 'creates an empty array of events' do
        expect(subject.events).to be_empty
      end
    end
  end

  describe 'log' do
    let(:event) {
      {
        something: 'oh i did something',
        time: 'at noon'
      }
    }

    it 'adds the event to the list of events' do
      logger.log(event)
      expect(logger.events).to include event
    end
  end
end
