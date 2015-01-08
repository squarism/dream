# used for emitting prisms
# TODO: perhaps this could be a particle system instead
# create_prism_path { x: 100, y: 200 }
# returns a new path with a destination point for tweening
#   { x1: 100, y1: 200, x2: ..., y2: ... }
def create_prism_path origin
  path = { x1: origin[:x], y1: origin[:y] }
  x2 = path[:x1] - 600
  y2 = path[:y1] + 600
  path.merge x2: x2, y2: y2
end

def emit_prism(origin, time=8_000)
  # require 'pry'; binding.pry
  path = create_prism_path origin
  prism = create_actor :prism, x:path[:x1], y:path[:y1], layer: 2
  # prism = create_actor :dream_prism, x:path[:x1], y:path[:y1], layer: 2
  tween = tween_manager.tween_properties prism, {x: path[:x2], y:path[:y2]}, time, Tween::Linear
  timer_manager.add_timer "kill_prism_#{prism.object_id}", time do
    prism.remove
  end
end


define_stage :dream do
  requires :behavior_factory, :tween_manager

  curtain_up do |*args|

    # person = create_actor :bedroom_covers, x:305, y:265, layer: 11
    # cat    = create_actor :bedroom_cat, x:520, y:345, layer: 11, action: :idle
    bg     = create_actor :bedroom_background_night, x:320, y:240, layer: 10

    moon   = create_actor :moon, x:160, y:80, layer: 2
    stars  = create_actor :starfield, x:320, y:240, layer: 1

    star_trails = nil

    # timing factors
    # TODO rename all these to _t
    moon_remove_time     = 3 # 30_000
    star_transition_lead = 5 # 15_000
    galaxy_fade_time     =  5_000

    # star trails
    trail_stop_time      = 12_400 + star_transition_lead
    trail_sustain_time   =  3_000 + trail_stop_time
    trail_release_time   =  8_000

    # This is the second set of prisms timing ... I don't want lines to overlap
    prism_intro_delay    = trail_stop_time + 14_000



    # Scene Events
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

    timer_manager.add_timer 'prism', trail_stop_time do
      timer_manager.remove_timer 'prism'
      emit_prism({ x: 450, y: -110 })
      emit_prism({ x: 700, y: -50 }, 12_500)
      emit_prism({ x: 600, y: -120 }, 19_500)
    end

    timer_manager.add_timer 'moar_prisms', prism_intro_delay do
      timer_manager.remove_timer 'moar_prisms'
      emit_prism({ x: 455, y: -110 }, 13_000)
      emit_prism({ x: 705, y: -50 }, 11_500)
      emit_prism({ x: 605, y: -120 }, 18_500)
      emit_prism({ x: 800, y: -140 }, 4_500)
    end



  end

end
