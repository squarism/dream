define_actor :player do
  has_behaviors do
    positioned
    fading time:3000
  end

  view do
    draw do |target, x_off, y_off, z|
      x = actor.x + x_off
      y = actor.y + y_off
      @color = Color.new(actor.alpha, 255, 255, 255)
      target.draw_box x,y, x+40, y+40, @color, 1
    end
  end
end
