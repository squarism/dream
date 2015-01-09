define_stage :test do
  requires :behavior_factory, :tween_manager

  curtain_up do |*args|

    butterfly = create_actor :butterfly, x:100, y:0, layer: 9, rotation: 0

    timer_manager.add_timer 'move', 100 do
      timer_manager.remove_timer 'move'
      tween = tween_manager.tween_properties butterfly, {x: 150, y:150}, 10_000, Tween::Sine::InOut
    end

  end

end