def create_path origin, destination
  path = { x1: origin[:x], y1: origin[:y] }
  x2 = path[:x1] + destination[:x]
  y2 = path[:y1] + destination[:y]
  path.merge x2: x2, y2: y2
end

def emit_object(object_name, origin, time=4_000, layer=10, &block)
  destination = block.call
  path = create_path origin, destination
  particle = create_actor object_name, x:path[:x1], y:path[:y1], layer: layer
  tween = tween_manager.tween_properties particle, { x:path[:x2], y:path[:y2] }, time, Tween::Linear
  behavior_factory.add_behavior particle, :fading
  particle.emit :fade_out, time
  timer_manager.add_timer "kill_particle_#{particle.object_id}", time + 200 do
    particle.remove
  end
end

define_stage :work do
  requires :behavior_factory, :sound_manager, :tween_manager

  curtain_up do |*args|
    opts = args.first || {}
    center_x = 427

    sound_manager.play_music :dream

    day_sky = create_actor :day_sky, x:center_x, y:240, layer: 0
    desk = create_actor :desk, x:center_x, y:226, layer:5
    desk_night = nil

    sun = create_actor :sun, x:110, y:180, layer: 1
    library = create_actor :library, x:center_x, y:240, layer:2

    # Timing
    close_desk_t = 25_200


    # Code Symbol Actors
    # ----------------------------------------------------------------
    # We could make an infinite particle system based on randomness
    # or some kind of generation loop but I prefer explicit control
    # because of timing and repeatability of recording videos and demos.
    timer_manager.add_timer 'symbol01', 3_000 do
      timer_manager.remove_timer 'symbol01'
      emit_object(:symbol01, { x:320, y:250 }) do
        { x:0, y:-100 }
      end
    end

    timer_manager.add_timer 'symbol02', 7_000 do
      timer_manager.remove_timer 'symbol02'
      emit_object(:symbol02, { x:480, y:200 }) do
        { x:0, y:-120 }
      end
    end

    timer_manager.add_timer 'symbol03', 12_000 do
      timer_manager.remove_timer 'symbol03'
      emit_object(:symbol03, { x:565, y:180 }) do
        { x:0, y:-150 }
      end
    end



    # Sky Actors
    # ----------------------------------------------------------------
    timer_manager.add_timer 'sundown', 10 do
      timer_manager.remove_timer 'sundown'
      tween_manager.tween_properties sun, { x:110, y:280 }, 20_000, Tween::Linear
    end

    timer_manager.add_timer 'sunfade', 5000 do
      timer_manager.remove_timer 'sunfade'
      behavior_factory.add_behavior sun, :fading
      sun.emit :fade_out, 25000
    end

    timer_manager.add_timer 'nightfade', 15000 do
      timer_manager.remove_timer 'nightfade'
      night_sky = create_actor :starfield, x:center_x, y:240, layer: -1
      behavior_factory.add_behavior night_sky, :fading
      night_sky.alpha = 0
      night_sky.emit :fade_in, 15000
    end

    timer_manager.add_timer 'bring_in_night', 2000 do
      timer_manager.remove_timer 'bring_in_night'
      day_sky.emit :fade_out, 25000
      desk_night = create_actor :desk_night, x:center_x, y:226, layer:4
      library_night = create_actor :library_night, x:center_x, y:240, layer:1
      desk.emit :fade_out, 14000
      library.emit :fade_out, 14000
    end

    timer_manager.add_timer 'close', close_desk_t do
      timer_manager.remove_timer 'close'
      desk_night.remove
      desk = create_actor :desk_close, x:center_x, y:226, layer:5
    end


    timer_manager.add_timer 'all_done', close_desk_t + 4_000 do
      fire :next_stage
    end

  end

end
