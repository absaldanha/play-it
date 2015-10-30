RSpec.describe PlayIt::Extraction::Parser do
  describe '.parse' do
    let(:unparsed_data) do
      load_json_sample 'unparsed_data.json'
    end

    let(:parsed_data) do
      symbolize_keys(load_json_sample('parsed_data.json'))
    end

    it 'parses the data' do
      expect(described_class.parse(unparsed_data)).to eq parsed_data
    end
  end
end
