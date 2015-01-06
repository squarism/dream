define_stage :walk do
  requires :behavior_factory

  curtain_up do |*args|
    opts = args.first || {}

    night_sky = create_actor :starfield, x:320, y:240, layer: 0

    # Street background
    street = create_actor :walk_foreground, x:320, y:280, layer: 2
    next_street_start = 920
    next_street = create_actor :walk_foreground, x:next_street_start, y:280, layer: 2
    # start parallax
    behavior_factory.add_behavior street, :sliding
    behavior_factory.add_behavior next_street, :sliding
    street.emit :slide, x:-320, y:280, time: 45000, style: Tween::Linear
    next_street.emit :slide, x:next_street_start-640, y:280, time: 45000, style: Tween::Linear

    # Tree background
    trees = create_actor :walk_trees, x:320, y:320, layer: 1
    next_trees_start = 920
    next_trees = create_actor :walk_trees, x:next_trees_start, y:320, layer: 1
    # start parallax
    behavior_factory.add_behavior trees, :sliding
    behavior_factory.add_behavior next_trees, :sliding

    trees.emit :slide, x:-260, y:320, time: 75000, style: Tween::Linear
    next_trees.emit :slide, x:next_trees_start-640, y:320, time: 75000, style: Tween::Linear


    timer_manager.add_timer 'all_done', 25000 do
      fire :next_stage
    end

  end

end
