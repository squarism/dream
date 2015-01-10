define_stage :test do
  requires :behavior_factory, :tween_manager

  curtain_up do |*args|

    rainbow_line_t      = 1500 #_000
    rainbow_line_cycles = 4

    butterfly = create_actor :butterfly, x:150, y:150, layer: 9, rotation: 0
    tween_manager.tween_properties butterfly, {x: 640, y:280}, rainbow_line_t, Tween::Sine::InOut

    timer_manager.add_timer 'rainbow_ne', rainbow_line_t * 1 do
      tween_manager.tween_properties butterfly, {x: 600, y:-100}, rainbow_line_t, Tween::Sine::InOut
    end

    timer_manager.add_timer 'rainbow_nw', rainbow_line_t * 2 do
      tween_manager.tween_properties butterfly, {x: 240, y:90}, rainbow_line_t, Tween::Sine::InOut
    end

    timer_manager.add_timer 'rainbow_sw', rainbow_line_t * 3 do
      tween_manager.tween_properties butterfly, {x: 340, y:280}, rainbow_line_t, Tween::Sine::InOut
    end


    timer_manager.add_timer 'stop_rainbow', (rainbow_line_t * (rainbow_line_cycles + 1) * 4) do
      timer_manager.remove_timer 'rainbow_ne'
      timer_manager.remove_timer 'rainbow_nw'
      timer_manager.remove_timer 'rainbow_sw'
    end

  end

end
