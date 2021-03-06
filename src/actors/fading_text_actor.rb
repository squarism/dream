define_actor :fading_text do

  has_behaviors do
    positioned
    fading time:1000
  end

  behavior do
    requires_behaviors :positioned
    requires :font_style_factory

    setup do
      actor.has_attributes text:      "",
                           x:         0,
                           y:         0,
                           font_size: Gamebox.configuration.default_font_size,
                           font_name: Gamebox.configuration.default_font_name,
                           color:     Color.new(255, 255, 255, 255),
                           layer:     1

      font_style = font_style_factory.build actor.font_name, actor.font_size, actor.color
      actor.has_attributes font_style: font_style
    end

    helpers do
      def remove
        actor.unsubscribe_all self
      end
    end

  end

  view do
    draw do |target, x_off, y_off, z|
      x = actor.x + x_off
      y = actor.y + y_off
      color = actor.color
      color.alpha = actor.alpha
      actor.font_style.font.draw actor.text, x, y, actor.layer, actor.font_style.x_scale, actor.font_style.y_scale, color
    end
  end
end
