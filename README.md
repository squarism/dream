    # Dream

Dream is a music video done in Ruby with gamebox.  Everything is original, be kind.  :)

![image](https://raw.githubusercontent.com/squarism/dream/images/images/dream_02.png)

[Video on Vimeo](https://vimeo.com/116836454)

## TODO

- Probably lots of shading to be done and played with.

- Remove opts

- Remove actor unused attributes

- Add symbols (textures done) to work scene

- Replace all behavior_factory with :tween_manager

- ALL TODOS

- Create a crossfade actor helper method.  Don't know how.  Put in src?


      def crossfade(actor, new_actor_name, time)
        behavior_factory.add_behavior actor, :fading
        actor.emit :fade_out, fall_asleep_t
        new_actor = create_actor new_actor_name, x:actor.x, y:actor.y, layer: actor.layer
        behavior_factory.add_behavior new_actor, :fading
        new_actor.emit :fade_int, time
        new_actor
      end

      class Crossfader
        construct_with :behavior_factory




## Dev Notes
- Texplay 0.4.4.pre is required, doesn't compile with Ruby 2?

- Had some weird drawing issues until I did an explicit alpha clear.
But only on certain machines.  Texplay creates a really empty buffer I guess.

- The project started as VGA (640x480) for no good reason.

- Definitely keep track of art assets between scenes.  Don't just adjust brightness.

- Should have timed the scenes better from the get-go.

- Work on vision a bit more maybe?  You can spend time implementing a crap idea just to see if you can implement it.  Idk.


## Art Notes

Backgrounds should be:

Width: 171 x Height 96 pixels
Position them at x:427, y:240 with scale:5
For 854x480 screen resolution.  They will fit perfectly.

Bedroom dim:
Saturation: -50%
Lightness: -80%

Nighttime dim (library):
Colorize - Pixelmator
Saturation: 55%
Lightness: -45%


The project started as VGA (640x480) for no good reason.
It should have been WXVGA (854x480).  This is going to cause
serious problems.

854x480 doesn't divide right by our pixel scaling.  171x96
Old center: 320  New center: 427

Eyes: #336699

