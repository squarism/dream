# Dream

## TODO

- Widescreen!  Aaaah!

- Probably lots of shading to be done and played with.

- Remove opts

- Remove actor unused attributes

- Add symbols (textures done) to work scene

- Replace all behavior_factory with :tween_manager

- Add moon craters

- Add lady falling sleep eyes

- ALL TODOS


## Dev Notes
- Texplay 0.4.4.pre is required, doesn't compile with Ruby 2?

- Had some weird drawing issues until I did an explicit alpha clear.
But only on certain machines.  Texplay creates a really empty buffer I guess.


## Art Notes

Backgrounds should be:

Width: 128 x Height 96 pixels
Position them at x:320, y:240 with scale:5
For 640x480 screen resolution.  They will fit perfectly.

Bedroom dim:
Saturation: -50%
Lightness: -80%

Nighttime dim (library):
Colorize - Pixelmator
Saturation: 55%
Lightness: -45%


The project started as VGA (640x480) for no good reason.
It really should be WXVGA (854x480).  This is going to cause
serious problems.

854x480 doesn't divide right by our pixel scaling.  171x96
Old center: 320  New center: 427

