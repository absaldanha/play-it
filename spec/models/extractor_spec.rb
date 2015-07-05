require './models/extractor'

describe Extractor do
  let!(:root_path) { File.expand_path("#{__FILE__}/../../..") }

  let!(:src_path) { "#{root_path}/spec/samples/musics/warriors.mp3" }
  let!(:dst_path) { "#{root_path}/tmp/tmp.json" }

  let!(:command_path) { "#{root_path}/bin" }
  let!(:command_name) { 'streaming_extractor_music' }

  let!(:invalid_path) { '/usr/local' }

  let!(:sample_extraction_output) {
    File.read('spec/samples/models/extractor_sample_extraction_output.json')
  }
  let!(:sample_output) {
    JSON.parse(File.read('spec/samples/models/extractor_sample_output.json'))
  }

  subject { described_class.new }

  it 'creates the command' do
    line = subject.send('command', src_path, dst_path)
    expect(line.command).to eq(
      "SET PATH=#{command_path};%PATH% & " \
      "#{command_name} #{src_path} #{dst_path}"
    )
  end

  describe '#run' do
    it 'raises exception when path is invalid' do
      expect {
        subject.send('run', invalid_path)
      }.to raise_error(ExtractionError)
    end

    it 'processes valid path', :slow do
      allow_any_instance_of(Tempfile).to receive(:read).
        and_return(sample_extraction_output)

      expect(subject.send('run', src_path)).to eq(sample_extraction_output)
    end
  end

  it 'parses the output' do
    result = subject.send('parse', sample_extraction_output)
    expect(result).to be_a Hash
    expect(result.keys).to eq(subject.instance_variable_get('@feature_list'))
  end

  it 'extracts features', :slow do
    allow_any_instance_of(Tempfile).to receive(:read).
        and_return(sample_extraction_output)

    expect(subject.extract(src_path)).to eq(sample_output)
  end
end
