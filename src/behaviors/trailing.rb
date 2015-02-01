define_behavior :trailing do
  requires :timer_manager
  setup do
    actor.has_attributes trails: [], trails_to_render: opts[:trails_to_render]

    timer_manager.add_timer timer_name, 100 do
      new_trail = { x:actor.x, y:actor.y, rotation:actor.rotation, hue:actor.hue }
      actor.trails << new_trail
      actor.trails.shift if actor.trails.size > actor.trails_to_render
    end
    reacts_with :remove
  end

  helpers do
    def timer_name
      "actor_trail_#{actor.object_id}"
    end
    def remove
      timer_manager.remove_timer timer_name
    end
  end
end