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

def emit_prism(origin, time=4_000)
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

    # Person and Cat actors
    person     = create_actor :bedroom_covers, x:352, y:287, layer: 11
    cat        = create_actor :bedroom_cat, x:627, y:367, layer: 11, action: :idle

    # Backgrounds
    bg           = create_actor :bedroom_background_night, x:427, y:240, layer: 10
    moon         = create_actor :moon, x:267, y:80, layer: 2
    stars        = create_actor :starfield, x:427, y:240, layer: 1
    galaxy_blank = nil
    star_trails  = nil

    # timing factors
    # TODO rename all these to _t
    moon_outro_t         = 24_000  # 24_000 is perfect
    moon_outro_speed     = 35_000
    moon_remove_t        = 24_000
    star_trans_lead_t    = 22_600 + moon_outro_t
    galaxy_fade_t        = 14_000
    star_remove_t        = star_trans_lead_t + galaxy_fade_t

    # star trails
    # star trail animation is 64 frames!  (64 * 200ms = 12800ms) :O
    trail_stop_t         =  6_200 + star_trans_lead_t
    trail_sustain_t      =  3_000 + trail_stop_t
    trail_release_t      =  8_000

    # This is the second set of prisms timing ... I don't want lines to overlap
    prism_intro_delay    = trail_stop_t + 4_000

    # the rainbow comes in sort of slowly so we don't need much delay
    rainbow_intro_t      = prism_intro_delay
    rainbow_line_t       = 15_000
    rainbow_stop_t       = 30_000
    wakeup_t             = 66_000 + moon_outro_t
    final_fade_t         = 5_500


    # Scene Events
    # -------------------------------------------------------------------------
    timer_manager.add_timer 'moon_slide', moon_outro_t do
      timer_manager.remove_timer 'moon_slide'
      behavior_factory.add_behavior moon, :sliding
      moon.emit :slide, x:267, y:-350, time: moon_outro_speed, style: Tween::Quad::InOut

      timer_manager.add_timer 'moon_remove', moon_remove_t do
        timer_manager.remove_timer 'moon_remove'
        moon.remove
      end
    end

    timer_manager.add_timer 'star_switch', star_trans_lead_t do
      timer_manager.remove_timer 'star_switch'
      galaxy_blank  = create_actor :starfield_galaxy_blank, x:427, y:240, layer: 0
      behavior_factory.add_behavior galaxy_blank, :fading
      behavior_factory.add_behavior stars, :fading
      galaxy_blank.emit :fade_in, galaxy_fade_t / 4
      stars.emit :fade_out, galaxy_fade_t
    end

    timer_manager.add_timer 'stars_remove', star_remove_t do
      timer_manager.remove_timer 'stars_remove'
      stars.remove
    end

    timer_manager.add_timer 'star_trails', star_trans_lead_t do
      timer_manager.remove_timer 'star_trails'
      star_trails = create_actor :star_trails, x:427, y:320, layer: 1
    end

    timer_manager.add_timer 'trail_stop', trail_stop_t do
      timer_manager.remove_timer 'trail_stop'
      star_trails.animating = false
    end

    timer_manager.add_timer 'trail_fade', trail_sustain_t do
      timer_manager.remove_timer 'trail_fade'
      behavior_factory.add_behavior star_trails, :fading
      star_trails.emit :fade_out, trail_release_t
    end

    timer_manager.add_timer 'prism', trail_stop_t do
      timer_manager.remove_timer 'prism'
      emit_prism({ x: 557, y: -110 })
      emit_prism({ x: 807, y: -50 },  6_500)
      emit_prism({ x: 707, y: -120 }, 8_500)
    end

    timer_manager.add_timer 'moar_prisms', prism_intro_delay do
      timer_manager.remove_timer 'moar_prisms'
      emit_prism({ x: 562,  y: -110 }, 6_000)
      emit_prism({ x: 812,  y: -50 },  5_500)
      emit_prism({ x: 712,  y: -120 }, 7_500)
      emit_prism({ x: 1057, y: -140 }, 2_500)
    end

    timer_manager.add_timer 'rainbow_intro', rainbow_intro_t do
      timer_manager.remove_timer 'rainbow_intro'

      behavior_factory.add_behavior galaxy_blank, :fading
      galaxy_blank.emit :fade_out, galaxy_fade_t

      butterfly = create_actor :butterfly, x:0, y:280, layer: 3, rotation: 0
      tween_manager.tween_properties butterfly, {x: 657, y:160}, rainbow_line_t, Tween::Sine::InOut

      timer_manager.add_timer 'rainbow_ne', rainbow_line_t * 1 do
        tween_manager.tween_properties butterfly, {x: 657, y:-80}, rainbow_line_t, Tween::Sine::InOut
      end

      timer_manager.add_timer 'rainbow_nw', rainbow_line_t * 2 do
        tween_manager.tween_properties butterfly, {x: 347, y:90}, rainbow_line_t, Tween::Sine::InOut
      end

      timer_manager.add_timer 'rainbow_sw', rainbow_line_t * 3 do
        tween_manager.tween_properties butterfly, {x: 447, y:140}, rainbow_line_t, Tween::Sine::InOut
      end

      timer_manager.add_timer 'stop_rainbow', rainbow_stop_t do
        timer_manager.remove_timer 'stop_rainbow'
        timer_manager.remove_timer 'rainbow_ne'
        timer_manager.remove_timer 'rainbow_nw'
        timer_manager.remove_timer 'rainbow_sw'
        tween_manager.tween_properties butterfly, {x: -1000, y:-1000}, rainbow_line_t, Tween::Sine::InOut

        timer_manager.add_timer 'remove_rainbow', rainbow_line_t do
          timer_manager.remove_timer 'remove_rainbow'
        end
      end

    end

    timer_manager.add_timer 'wakeup', wakeup_t do
      timer_manager.remove_timer 'wakeup'

      # wakeup is 19 frames of animation @ 200ms
      wakeup = create_actor :wakeup, x:412, y:287, layer: 11
      person.remove
      timer_manager.add_timer 'stop_wakeup', 3_600 do
        timer_manager.remove_timer 'stop_wakeup'

        wakeup.animating = false

        # final fade out
        curtain = create_actor :black, x:viewport.width/2, y:viewport.height/2, layer: 9_999
        behavior_factory.add_behavior curtain, :fading
        curtain.alpha = 0
        curtain.emit :fade_in, 5_500

        timer_manager.add_timer 'all_done', 6_900 do
          fire :next_stage
        end
      end
    end


  end

end
