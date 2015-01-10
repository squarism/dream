define_behavior :rotating do
  requires :director

  setup do
    actor.has_attribute :rotation, 0
    actor.has_attribute :rotation_speed, opts[:rotation_speed] || 0.5

    director.when :update do |time|
      actor.rotation += actor.rotation_speed
      actor.rotation = 0 if actor.rotation >= 360
    end

  end

  remove do
      actor.unsubscribe_all self
  end

end