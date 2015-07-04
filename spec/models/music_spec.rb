require './models/music'

RSpec.describe Music do

  let!(:path_example) { '/usr/example.mp3' }
  let!(:features_example) { {foo: 5.4, bar: 2} }

  subject(:music_with_features) { Music.new(path_example, features_example) }
  subject(:music_without_features) { Music.new(path_example) }

  it 'should be of class Music' do
    expect(music_without_features.class).to equal(Music)
    expect(music_with_features.class).to equal(Music)
  end

  it 'should have a path and no features' do
    expect(music_without_features.path).to eq(path_example)
    expect(music_without_features.features).to be_empty
  end

  it 'should have a path and features' do
    expect(music_with_features.path).to eq(path_example)
    expect(music_with_features.features).to eq(features_example)
  end
end