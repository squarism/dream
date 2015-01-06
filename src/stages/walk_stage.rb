define_stage :walk do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    night_sky = create_actor :starfield, x:320, y:240, layer: 0

    # Street background
    street = create_actor :walk_foreground, x:320, y:280, layer: 3
    next_street_start = 920
    next_street = create_actor :walk_foreground, x:next_street_start, y:280, layer: 3
    # start parallax
    behavior_factory.add_behavior street, :sliding
    behavior_factory.add_behavior next_street, :sliding
    street.emit :slide, x:-320, y:280, time: 45000, style: Tween::Linear
    next_street.emit :slide, x:next_street_start-640, y:280, time: 45000, style: Tween::Linear

    # Tree background
    trees = create_actor :walk_trees, x:320, y:300, layer: 2
    next_trees_start = 920
    next_trees = create_actor :walk_trees, x:next_trees_start, y:300, layer: 2
    # start parallax
    behavior_factory.add_behavior trees, :sliding
    behavior_factory.add_behavior next_trees, :sliding

    trees.emit :slide, x:-260, y:300, time: 75000, style: Tween::Linear
    next_trees.emit :slide, x:next_trees_start-640, y:300, time: 75000, style: Tween::Linear

    # Moon
    moon = create_actor :moon, x:120, y:140, layer: 1
    behavior_factory.add_behavior moon, :sliding
    moon.emit :slide, x:120, y:140, time: 40000, style: Tween::Linear

    # Walking Lady
    person = create_actor :walk_person, x:-20, y:285, layer: 4
    behavior_factory.add_behavior person, :sliding
    person.emit :slide, x:90, y:285, time: 24000, style: Tween::Linear

    # Lamps
    lamps = []
    lamp_distance = 440
    (0..3).each do |i|
      lamps << create_actor(:walk_lamp, x:(120 + (lamp_distance * i)), y:232, layer: 5)
      behavior_factory.add_behavior lamps[i], :sliding
      lamps[i].emit :slide, x:(-520 + (lamp_distance * i)), y:232, time: 45000, style: Tween::Linear
    end

    # maximum stage time is about 42 seconds
    timer_manager.add_timer 'all_done', 24000 do
      fire :next_stage
    end

  end

end
