define_actor :desk_night do
  has_attributes action: :idle, view: :graphical_actor_view

  has_behaviors do
    animated frame_update_time: 200
    graphical scale: 8
    fading time:5000
    visible
    layered
  end

  behavior do
    setup do
      actor.has_attributes width: 150, height: 350
    end
  end

  view do
    draw do |target, x_off, y_off, z|
      x = actor.x + x_off
      y = actor.y + y_off
      color = Color.new(actor.alpha, 81, 141, 255)
      require 'pry'; binding.pry
      # actor.font_style.font.draw actor.text, x, y, actor.layer, actor.font_style.x_scale, actor.font_style.y_scale, color
    end
  end

end