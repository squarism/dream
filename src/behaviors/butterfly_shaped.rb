define_behavior :butterfly_shaped do
  requires :director, :tween_manager

  setup do
    actor.has_attribute :width, 256
    actor.has_attribute :height, 256
    actor.has_attribute :line_thickness, 3
  end

  remove do
      actor.unsubscribe_all self
  end


end