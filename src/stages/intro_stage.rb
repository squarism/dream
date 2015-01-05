define_stage :intro do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    message = create_actor :fading_text, text: "INTRO ...", x: 50, y:50, width: 25, height:35

    timer_manager.add_timer 'intro', 500 do
      message.emit :fade_out, 4500
      timer_manager.remove_timer 'intro'
    end

    timer_manager.add_timer 'slide', 500 do
      behavior_factory.add_behavior message, :sliding
      message.emit :slide, x:50, y:60, time: 4000
      timer_manager.remove_timer 'slide'
    end

    timer_manager.add_timer 'all_done', 5000 do
      fire :next_stage
    end

  end

end
