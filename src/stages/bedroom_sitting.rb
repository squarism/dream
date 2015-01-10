define_stage :bedroom_sitting do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    create_actor :starfield, x:320, y:240, layer: 1
    create_actor :moon, x:160, y:80, layer: 2

    bedroom = create_actor :bedroom_background, x:320, y:240, layer: 10
    person = create_actor :bedroom_sitting, x:305, y:287, layer: 11, action: :idle
    cat = create_actor :bedroom_cat, x:520, y:367, layer: 11, action: :idle

    # idle breathe is 5 frames
    # two loops of breathing, then yawn
    timer_manager.add_timer 'yawn', 7_000 do
      timer_manager.remove_timer 'yawn'
      person.action = :yawn
    end

    # yawn is 4 frames
    timer_manager.add_timer 'breathe', 8_600 do
      timer_manager.remove_timer 'breathe'
      person.action = :idle
    end

    # cat tail is 6 frames long
    timer_manager.add_timer 'cat_tail', 7_200 do
      cat.action = :tail
    end

    # cat breathe is 6 frames long
    timer_manager.add_timer 'cat_breathe', 9_600 do
      cat.action = :idle
    end

    # reach is 20 frames
    timer_manager.add_timer 'reach', 13_000 do
      timer_manager.remove_timer 'reach'
      person.action = :reach
    end

    # switch out the background so it looks like the lights turn off
    # also this is precisely synced to the reach animation which
    # goes grayscale itself to look like the lights went off
    timer_manager.add_timer 'lights_off', 16_000 do
      timer_manager.remove_timer 'lights_off'
      create_actor :bedroom_background_night, x:320, y:240, layer: 10
      bedroom.remove
    end

    # This it the transition phase to the next scene where the
    # actors are still.  Very important to have actors still
    # before starting something new.  Makes it easier to transition.
    timer_manager.add_timer 'lay_in_bed', 20_800 do
      timer_manager.remove_timer 'lay_in_bed'
      person.remove
      create_actor :bedroom_covers, x:305, y:287, layer: 11
    end


    timer_manager.add_timer 'all_done', 66_000 do
      fire :next_stage
    end

  end

end