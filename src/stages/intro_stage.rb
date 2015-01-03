define_stage :intro do

  curtain_up do |*args|
    opts = args.first || {}

    message = create_actor :fading_text, text: "IN THE BEGINNING ...", x: 50, y:50, width: 25, height:35

    timer_manager.add_timer 'text', 1000 do
      message.emit :fade_out, 5000
      timer_manager.remove_timer 'text'
    end

    timer_manager.add_timer 'all_done', 6000 do
      fire :next_stage
    end

    director.when :all_done do
      puts "got all_done signal!"
      fire :next_stage
    end
  end

end
