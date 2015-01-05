define_stage :close do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    desk = create_actor :desk_close, x:330, y:226, layer:5
    library = create_actor :library_night, x:320, y:240, layer:2
    night_sky = create_actor :starfield, x:320, y:240, layer: -1

    timer_manager.add_timer 'all_done', 4000 do
      fire :next_stage
    end

  end

end
