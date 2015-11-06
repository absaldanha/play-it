PlayIt::Config.configure do |config|
  config.library_path = './library.dat'
  config.command_path = File.expand_path('./../../bin', __FILE__)
  config.profile_path = File.expand_path('./../../profile.yaml', __FILE__)
end
