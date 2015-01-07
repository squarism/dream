# Dream

## TODO

- The project started as VGA (640x480) for no good reason.
It really should be WXVGA (854x480).  This is going to cause
serious refactoring problems.

- All parallax effects should be generators (like the street lamp is).
  Right now they are hardcoded and that's going to make widescreen error prone.

- Shade the lean animation.

- Probably lots of shading to be done and played with.

- Final timing?

- Little person hair


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


Bedroom dim:
Saturation: -50%
Lightness: -80%
