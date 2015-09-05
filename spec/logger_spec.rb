RSpec.describe PlayIt::Logger do
  describe '#log' do
    let(:event) do
      {
        something: 'oh i did something',
        time: 'at noon'
      }
    end

    before { subject.log(event) }

    it 'adds the event to the list of events' do
      expect(subject.events).to include event
    end
  end
end
