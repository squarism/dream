define_stage :house do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    # backgrounds
    create_actor :starfield, x:320, y:240, layer: 0
    create_actor :moon, x:60, y:100, layer: 1
    create_actor :house_background, x:320, y:240, layer: 2
    create_actor :house_grass, x:460, y:360, layer: 6
    create_actor :walk_lamp, x:233, y:193, layer: 7

    little_person = nil
    open_door = nil

    # lady
    person = create_actor :walk_person, x:60, y:245, layer: 3
    behavior_factory.add_behavior person, :sliding
    person.emit :slide, x:245, y:245, time: 8000, style: Tween::Linear


    timer_manager.add_timer 'sidewalk', 8000 do
      timer_manager.remove_timer 'sidewalk'
      person.emit :slide, x:266, y:237, time: 1000, style: Tween::Sine::InOut
    end

    timer_manager.add_timer 'hill', 9000 do
      timer_manager.remove_timer 'hill'
      person.emit :slide, x:335, y:270, time: 3000, style: Tween::Sine::InOut
    end

    timer_manager.add_timer 'steps', 11000 do
      timer_manager.remove_timer 'steps'
      person.emit :slide, x:375, y:350, time: 4000, style: Tween::Sine::InOut
    end

    timer_manager.add_timer 'little_person', 15000 do
      timer_manager.remove_timer 'little_person'
      person.remove

      little_person = create_actor :little_person, x:395, y:310, layer: 5
      behavior_factory.add_behavior little_person, :sliding
      little_person.emit :slide, x:498, y:215, time: 6000, style: Tween::Quad::InOut
    end

    timer_manager.add_timer 'door_open', 21000 do
      timer_manager.remove_timer 'door_open'
      open_door = create_actor :house_door_open, x:495, y:193, layer: 4
      little_person.remove
    end

    timer_manager.add_timer 'door_close', 22000 do
      timer_manager.remove_timer 'door_close'
      open_door.remove
    end

    timer_manager.add_timer 'light_on', 23800 do
      timer_manager.remove_timer 'light_on'
      light = create_actor :house_light, x:410, y:181, layer: 5
      behavior_factory.add_behavior light, :fading
      light.alpha = 0
      light.emit :fade_in, 2000
    end

    timer_manager.add_timer 'all_done', 36000 do
      fire :next_stage
    end

  end

end
