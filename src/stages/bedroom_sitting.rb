define_stage :bedroom_sitting do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    create_actor :starfield, x:320, y:240, layer: 1
    create_actor :moon, x:90, y:80, layer: 2
    create_actor :bedroom_background, x:320, y:240, layer: 10
    person = create_actor :bedroom_sitting, x:365, y:337, layer: 11, action: :idle
    cat = create_actor :bedroom_cat, x:520, y:345, layer: 11, action: :idle
    # behavior_factory.add_behavior person, :fading

    # idle breathe is 5 frames
    # two loops of breathing, then yawn
    timer_manager.add_timer 'yawn', 4000 do
      timer_manager.remove_timer 'yawn'
      person.action = :yawn
    end

    # yawn is 4 frames
    timer_manager.add_timer 'breathe', 5600 do
      timer_manager.remove_timer 'breathe'
      person.action = :idle
    end

    # cat tail is 6 frames long
    timer_manager.add_timer 'cat_tail', 7200 do
      cat.action = :tail
    end

    # cat breathe is 6 frames long
    timer_manager.add_timer 'cat_breathe', 9600 do
      cat.action = :idle
    end


    timer_manager.add_timer 'all_done', 30000 do
      fire :next_stage
    end

  end

end