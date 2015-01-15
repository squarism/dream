def spawn_point
  viewport.width * 1.5
end

def parallax_system(actor_name, layer)
  system = []
  system << create_actor(actor_name, x:viewport.width / 2, y:280, layer: layer)
  system << create_actor(actor_name, x:spawn_point, y:280, layer: layer)
end

def start_parallax_system(system, time)
  system.each do |actor|
    start_parallax_actor(actor, time)
  end
end

def start_parallax_actor(actor, time)
  destination = -viewport.width * 1.5
  t = (actor.x - destination) * time / viewport.width
  behavior_factory.add_behavior actor, :sliding
  actor.emit :slide, x:destination, y:actor.y, time: t, style: Tween::Linear
end

def spawn_parallax_actor(actor_name, system, layer)
  spawn_x = system.first.x + (viewport.width * 2.0)
  create_actor(actor_name, x:spawn_x, y:280, layer: layer)
end

# when first texture is halfway off the screen, spawn #3
def respawn_parallax(actor_name, system, time, layer)
  if system.length < 3 && system.first.x < viewport.width / 2
    actor = spawn_parallax_actor(actor_name, system, layer)
    start_parallax_actor(actor, time)
    system << actor
  end

  if system.first.x <= -viewport.width
    dead = system.shift
    dead.remove
  end
end


define_stage :walk do
  requires :behavior_factory

  curtain_up do |*args|
    center_x = 427
    night_sky = create_actor :starfield, x:center_x, y:240, layer: 0
    grass = create_actor :walk_grass_bg, x:center_x, y:280, layer: 2

    streets = parallax_system(:walk_foreground, 4)
    start_parallax_system(streets, 45_000)

    trees = parallax_system(:walk_trees, 3)
    start_parallax_system(trees, 75_000)


    # a painful parallax system
    director.when :update do |time|
      respawn_parallax(:walk_foreground, streets, 45_000, 4)
      respawn_parallax(:walk_trees, trees, 75_000, 3)
    end

    # Walking Lady
    person = create_actor :walk_person, x:-20, y:285, layer: 10
    behavior_factory.add_behavior person, :sliding
    person.emit :slide, x:235, y:285, time: 44000, style: Tween::Linear

    # Lamps
    lamps = []
    lamp_distance = 440
    (0..3).each do |i|
      lamps << create_actor(:walk_lamp, x:(120 + (lamp_distance * i)), y:232, layer: 11)
      behavior_factory.add_behavior lamps[i], :sliding
      fudge_factor = 115 # TODO: sliding math?  They move slightly too fast on the street.
      lamp_destination = (-viewport.width + (lamp_distance * i)) + fudge_factor
      lamps[i].emit :slide, x:lamp_destination, y:232, time: 45_000, style: Tween::Linear
    end

    timer_manager.add_timer 'fade_moon', 12000 do
        timer_manager.remove_timer 'fade_moon'
        moon = create_actor :moon, x:120, y:440, layer: 1
        behavior_factory.add_behavior moon, :sliding
        moon.emit :slide, x:120, y:120, time: 22000, style: Tween::Quad::InOut
    end

    # maximum stage time is about 42 seconds
    timer_manager.add_timer 'all_done', 42_300 do
      fire :next_stage
    end

  end

end
