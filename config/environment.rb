APP_ROOT = "#{File.join(File.dirname(__FILE__),"..")}/"

require 'yaml'
require 'gamebox'
require 'releasy'
require 'texplay'

Gamebox.configure do |config|
  config.config_path = APP_ROOT + "config/"
  config.data_path = APP_ROOT + "data/"
  config.music_path = APP_ROOT + "data/music/"
  config.sound_path = APP_ROOT + "data/sounds/"
  config.gfx_path = APP_ROOT + "data/graphics/"
  config.fonts_path = APP_ROOT + "data/fonts/"

  config.gb_config_path = GAMEBOX_PATH + "config/"
  config.gb_data_path = GAMEBOX_PATH + "data/"
  config.gb_music_path = GAMEBOX_PATH + "data/music/"
  config.gb_sound_path = GAMEBOX_PATH + "data/sounds/"
  config.gb_gfx_path = GAMEBOX_PATH + "data/graphics/"
  config.gb_fonts_path = GAMEBOX_PATH + "data/fonts/"

  config.default_font_name = "fru_ext.ttf"
  config.default_font_color = Color.argb(255, 244, 215, 227)
  config.default_font_size = 32

  # config.stages = [:intro, :work, :walk, :house, :bedroom_sitting, :dream]
  config.stages = [:dream]

  config.game_name = "Dream"
end

[GAMEBOX_PATH, APP_ROOT, File.join(APP_ROOT,'src')].each{|path| $: << path }
require "gamebox_application"

require_all Dir.glob("{src,lib}/**/*.rb").reject{ |f| f.match("src/app.rb")}


# Pixel art style.  At least they admit it's undocumented?  :|
Gosu::enable_undocumented_retrofication
