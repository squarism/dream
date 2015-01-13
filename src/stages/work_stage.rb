define_stage :work do
  requires :behavior_factory, :sound_manager

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


    timer_manager.add_timer 'sundown', 10 do
      timer_manager.remove_timer 'sundown'
      behavior_factory.add_behavior sun, :sliding
      sun.emit :slide, x:110, y:280, time: 20_000, style: Tween::Linear
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
