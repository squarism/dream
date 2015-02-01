define_stage :bedroom_sitting do
  requires :behavior_factory

  curtain_up do |*args|
    create_actor :starfield, x:427, y:240, layer: 1
    create_actor :moon, x:267, y:80, layer: 2

    bedroom = create_actor :bedroom_background, x:427, y:240, layer: 10
    person = create_actor :bedroom_sitting, x:352, y:287, layer: 11, action: :idle
    cat = create_actor :bedroom_cat, x:627, y:367, layer: 11, action: :idle

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
      create_actor :bedroom_background_night, x:427, y:240, layer: 10
      bedroom.remove
    end

    # This it the transition phase to the next scene where the
    # actors are still.  Very important to have actors still
    # before starting something new.  Makes it easier to transition.
    timer_manager.add_timer 'lay_in_bed', 20_800 do
      timer_manager.remove_timer 'lay_in_bed'
      person.remove
      create_actor :bedroom_covers, x:352, y:287, layer: 11
      face = create_actor :bedroom_face, x:232, y:377, layer: 12, action: :idle

      # start blinking loops
      timer_manager.add_timer 'blink', 9_600 do
        face.action = :blink
      end

      timer_manager.add_timer 'blink_stop', 9_800 do
        face.action = :idle
      end

    end

    # This timing is very critical, if you change it,
    # you have to consider the moon is animating but staying
    # between scenes.  so you'd have to figure out the delta
    # change in order to not make the moon "blink".  I would just
    # leave this alone and change other timing.
    timer_manager.add_timer 'all_done', 44_000 do
      fire :next_stage
    end

  end

end