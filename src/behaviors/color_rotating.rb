define_behavior :color_rotating do
  requires :director

  setup do
    actor.has_attribute :color_wheel, Gosu::Color.new(0xffff0000)
    actor.has_attribute :hue, 0
    actor.has_attribute :hue_speed, 0.5

    director.when :update do |time|
      update_hue(actor.hue_speed)
    end

  end

  remove do
      actor.unsubscribe_all self
  end

  helpers do

    def update_hue(increment)
      actor.hue += increment
      actor.hue = 0 if actor.hue >= 360
    end

  end

end