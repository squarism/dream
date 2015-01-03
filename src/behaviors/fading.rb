define_behavior :fading do
  requires :director

  setup do
    actor.has_attribute :alpha, 255
    actor.has_attribute :tween
    actor.has_attributes tween_time: opts[:time]

    director.when :update do |time|
      if actor.tween
        if !actor.tween.done
          update_alpha time
        else
          actor.tween = nil
        end
      end
    end

    actor.when :fade_out, &method(:fade_out)
    actor.when :fade_in, &method(:fade_in)
  end

  remove do
    actor.unsubscribe_all self
  end

  helpers do

    def update_alpha(time)
      actor.tween.update time
      actor.alpha = actor.tween.value
    end

    def fade_out(time = actor.tween_time)
      actor.tween = Tween.new(255, 0, Tween::Linear, time)
    end

    def fade_in(time = actor.tween_time)
      actor.tween = Tween.new(0, 255, Tween::Linear, time)
    end

  end

end