define_behavior :butterfly_shaped do
  requires :director, :tween_manager

  setup do
    actor.has_attribute :width, 64
    actor.has_attribute :height, 64
    actor.has_attribute :trail, 1
  end

  remove do
      actor.unsubscribe_all self
  end


end