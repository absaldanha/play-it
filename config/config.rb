PlayIt::Configuration.configure do |config|
  config.library_path = './library.dat'
  config.command_path = File.expand_path('./../../bin', __FILE__)
  config.profile_path = File.expand_path('./../../profile.yml', __FILE__)
  config.inner_ring_chance = 5
  config.outer_ring_chance = 5
  # config.library_path = File.expand_path('../../library.dat', __FILE__)

  config.view_structure_path = File.expand_path(
    '../../lib/play_it/player/view/player.ui', __FILE__
  )

  config.view_css_path = File.expand_path(
    '../../assets/stylesheets/player.css', __FILE__
  )
end
