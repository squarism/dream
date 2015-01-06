define_behavior :sliding do
  requires :director

  setup do
    actor.has_attribute :x_tween
    actor.has_attribute :y_tween
    actor.has_attributes tween_time: opts[:time]

    director.when :update do |time|
      if actor.x_tween
        if !actor.x_tween.done
          update_position time
        else
          actor.x_tween = nil
          actor.y_tween = nil
        end
      end
    end

    actor.when :slide, &method(:slide)
  end

  # When subscribing to the director, one must also unsubscribe or strange things may happen.
  # -- shawn42
  remove do
    actor.unsubscribe_all self
  end

  helpers do

    def update_position(time)
      actor.x_tween.update time
      actor.y_tween.update time
      actor.x = actor.x_tween.value
      actor.y = actor.y_tween.value
    end

    def slide(x:, y:, time: actor.tween_time, style: Tween::Quad::InOut)
      actor.x_tween = Tween.new(actor.x, x, style, time)
      actor.y_tween = Tween.new(actor.y, y, style, time)
    end

  end

end