define_stage :work do

  curtain_up do |*args|
    opts = args.first || {}

    desk = create_actor :desk, x:330, y:226, layer:4
    # sun = create_actor :sun, x:60, y:60
    library = create_actor :library, x:320, y:240, layer:1

    timer_manager.add_timer 'bring_in_night', 2000 do
      desk_night = create_actor :desk_night, x:330, y:226, layer:3
      library_night = create_actor :library_night, x:320, y:240, layer:0

      desk.emit :fade_out, 15000
      library.emit :fade_out, 15000

      timer_manager.remove_timer 'bring_in_night'
    end

    timer_manager.add_timer 'all_done', 30000 do
      fire :next_stage
    end

  end

end
