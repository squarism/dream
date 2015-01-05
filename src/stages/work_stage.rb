define_stage :work do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    day_sky = create_actor :day_sky, x:320, y:240, layer: 0
    desk = create_actor :desk, x:330, y:226, layer:5

    sun = create_actor :sun, x:60, y:60, layer: 1
    library = create_actor :library, x:320, y:240, layer:2


    timer_manager.add_timer 'sundown', 10 do
      timer_manager.remove_timer 'sundown'
      behavior_factory.add_behavior sun, :sliding
      sun.emit :slide, x:60, y:200, time: 25000, style: Tween::Linear
    end

    timer_manager.add_timer 'sunfade', 5000 do
      timer_manager.remove_timer 'sunfade'
      behavior_factory.add_behavior sun, :fading
      sun.emit :fade_out, 25000
    end

    timer_manager.add_timer 'nightfade', 20000 do
      timer_manager.remove_timer 'nightfade'
      night_sky = create_actor :starfield, x:320, y:240, layer: -1
      night_sky.alpha = 0
      night_sky.emit :fade_in, 10000
    end

    timer_manager.add_timer 'bring_in_night', 2000 do
      timer_manager.remove_timer 'bring_in_night'
      day_sky.emit :fade_out, 20000
      desk_night = create_actor :desk_night, x:330, y:226, layer:4
      library_night = create_actor :library_night, x:320, y:240, layer:1
      desk.emit :fade_out, 15000
      library.emit :fade_out, 15000
    end

    # timer_manager.add_timer 'close_laptop', 17000 do
    #   timer_manager.remove_timer 'close_laptop'
    # end

    timer_manager.add_timer 'all_done', 30000 do
      fire :next_stage
    end

  end

end
