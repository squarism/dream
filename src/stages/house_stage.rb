define_stage :house do
  requires :behavior_factory, :tween_manager

  curtain_up do |*args|
    center_x = 427

    # backgrounds
    create_actor :starfield, x:center_x, y:240, layer: 0
    create_actor :moon, x:60, y:100, layer: 1
    create_actor :walk_grass_bg, x:center_x, y:280, layer: 2
    create_actor :house_background, x:center_x, y:240, layer: 3
    create_actor :house_grass, x:700, y:340, layer: 6
    create_actor :walk_lamp, x:233, y:193, layer: 7

    little_person = nil
    open_door = nil

    # lady
    person = create_actor :walk_person, x:167, y:245, layer: 4
    tween_manager.tween_properties person, { x:352, y:245 }, 8000, Tween::Linear


    timer_manager.add_timer 'sidewalk', 8000 do
      timer_manager.remove_timer 'sidewalk'
      tween_manager.tween_properties person, { x:373, y:237 }, 1000, Tween::Sine::InOut
    end

    timer_manager.add_timer 'hill', 9000 do
      timer_manager.remove_timer 'hill'
      tween_manager.tween_properties person, { x:442, y:270 }, 3000, Tween::Sine::InOut
    end

    timer_manager.add_timer 'steps', 11000 do
      timer_manager.remove_timer 'steps'
      tween_manager.tween_properties person, { x:482, y:340 }, 4000, Tween::Sine::InOut
    end

    timer_manager.add_timer 'little_person', 15000 do
      timer_manager.remove_timer 'little_person'
      person.remove

      little_person = create_actor :little_person, x:502, y:310, layer: 5
      tween_manager.tween_properties little_person, { x:596, y:215 }, 8000, Tween::Quad::InOut
    end

    timer_manager.add_timer 'door_open', 22_000 do
      timer_manager.remove_timer 'door_open'
      open_door = create_actor :house_door_open, x:600, y:193, layer: 4
      little_person.remove
    end

    timer_manager.add_timer 'door_close', 24000 do
      timer_manager.remove_timer 'door_close'
      open_door.remove
    end

    timer_manager.add_timer 'light_on', 25_800 do
      timer_manager.remove_timer 'light_on'
      light = create_actor :house_light, x:515, y:180, layer: 6
      behavior_factory.add_behavior light, :fading
      light.alpha = 0
      light.emit :fade_in, 3000
    end

    timer_manager.add_timer 'shooting_star', 30_000 do
      timer_manager.remove_timer 'shooting_star'
      star = create_actor :shooting_star, x:587, y:-90, layer: 1
      behavior_factory.add_behavior star, :fading
      star.alpha = 160
      tween_manager.tween_properties star, { x:0, y:viewport.height }, 1500, Tween::Quad::InOut
    end

    timer_manager.add_timer 'curtain', 34_000 do
      timer_manager.remove_timer 'curtain'
      create_actor :curtain, duration_in_ms: 4000, dir: :down
    end


    timer_manager.add_timer 'all_done', 38000 do
      fire :next_stage
    end

  end

end
