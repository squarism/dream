# Dream


## Dev Notes
Backgrounds should be:

Width: 128 x Height 96 pixels
Position them at x:320, y:240 with scale:5
For 640x480 screen resolution.  They will fit perfectly.

### Buffer Effects!

Ooo... I should try this:

texture = Gosu::Image.to_blob
image = ChunkyPNG::Image.from_blob(texture)
# Do effects with compass-magick?
#   https://github.com/StanAngeloff/compass-magick/blob/master/lib/magick/functions/operations/effects.rb

How to get back?  I don't know!  :)