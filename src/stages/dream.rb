define_stage :dream do
  requires :behavior_factory, :tween_manager

  curtain_up do |*args|

    person = create_actor :bedroom_covers, x:305, y:265, layer: 11
    cat    = create_actor :bedroom_cat, x:520, y:345, layer: 11, action: :idle
    bg     = create_actor :bedroom_background_night, x:320, y:240, layer: 10
    moon   = create_actor :moon, x:160, y:80, layer: 2
    stars  = create_actor :starfield, x:320, y:240, layer: 1

    star_trails = nil

    # timing factors
    # TODO rename all these to _t
    moon_remove_time     = 30_000
    star_transition_lead = 15_000
    galaxy_fade_time     =  5_000
    trail_stop_time      = 12_400 + star_transition_lead
    trail_sustain_time   =  3_000 + trail_stop_time
    trail_release_time   =  8_000
    prism_introduction_t = trail_sustain_time + trail_release_time
    prism_sustain_t      = prism_introduction_t + 8_000


    # I need programmatic drawing at this point.
    # Hand-animating things that look like Math is annoying.
    # timer_manager.add_timer 'asdf', 0 do
    #   timer_manager.remove_timer 'asdf'
    #   math = create_actor :math, x:250, y:250, layer: 9000
    #   behavior_factory.add_behavior math, :sliding
    #   moon.emit :slide, x:300, y:480, time: 5000
    #   math.layer = 2
    #   # require 'pry'; binding.pry
    #   # a = 1
    # end

    # Timing
    # -------------------------------------------------------------------------
    timer_manager.add_timer 'moon_slide', 0 do
      timer_manager.remove_timer 'moon_slide'
      behavior_factory.add_behavior moon, :sliding
      moon.emit :slide, x:160, y:-380, time: moon_remove_time, style: Tween::Quad::InOut
    end

    timer_manager.add_timer 'moon_remove', moon_remove_time do
      timer_manager.remove_timer 'moon_remove'
      moon.remove
    end

    timer_manager.add_timer 'star_switch', star_transition_lead do
      timer_manager.remove_timer 'star_switch'
      galaxy  = create_actor :starfield_galaxy_blank, x:320, y:240, layer: 0
      behavior_factory.add_behavior galaxy, :fading
      behavior_factory.add_behavior stars, :fading
      galaxy.emit :fade_in, galaxy_fade_time / 4
      stars.emit :fade_out, galaxy_fade_time
    end

    timer_manager.add_timer 'stars_remove', (star_transition_lead + galaxy_fade_time) do
      timer_manager.remove_timer 'stars_remove'
      stars.remove
    end

    timer_manager.add_timer 'star_trails', star_transition_lead do
      timer_manager.remove_timer 'star_trails'
      star_trails = create_actor :star_trails, x:320, y:320, layer: 1
    end

    timer_manager.add_timer 'trail_stop', trail_stop_time do
      timer_manager.remove_timer 'trail_stop'
      star_trails.animating = false
    end

    # star trail animation is 64 frames!  (64 * 200ms = 12800ms) :O
    timer_manager.add_timer 'trail_fade', trail_sustain_time do
      timer_manager.remove_timer 'trail_fade'
      behavior_factory.add_behavior star_trails, :fading
      star_trails.emit :fade_out, trail_release_time
    end

    timer_manager.add_timer 'prism', prism_introduction_t do
      timer_manager.remove_timer 'prism'
      prism = create_actor :dream_prism, x:550, y:-20, layer: 2
      tween = tween_manager.tween_properties prism, {x: 150, y:590}, 12_000, Tween::Sine::InOut
    end



  end

end
