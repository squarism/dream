def rotated_point(pair, angle)
  i = pair[0]
  j = pair[1]
  x = i * Math.cos(angle) - j * Math.sin(angle)
  y = j * Math.cos(angle) + i * Math.sin(angle)
  [x, y]
end

define_actor_view :butterfly_view do

  draw do |screen, x_offset, y_offset, z|
    x = actor.x + x_offset
    y = actor.y + y_offset

    scaling_factor = 3
    texture_size = 256

    offscreen_buffer = TexPlay::create_blank_image(screen.screen, texture_size, texture_size)
    # very important to clear the buffer explicitly, otherwise you get random texture memory
    offscreen_buffer.clear color: :alpha

    white = Gosu::Color.new(0xffff9999)
    white.hue = actor.hue

    lstart = [x - actor.width/2, y + actor.height/2]
    lend   = [x + actor.width/2, y - actor.height/2]

    # require 'pry'; binding.pry
    trail_length = 35

    (0...actor.trail).each do |trail_i|
      color = white.dup
      color.hue -= 3
      x1 = lstart[0] - (Gosu::offset_x(actor.rotation, trail_length))
      y1 = lstart[1] - (Gosu::offset_y(actor.rotation, trail_length))
      x2 = lstart[0] + (Gosu::offset_x(actor.rotation, trail_length))
      y2 = lstart[1] + (Gosu::offset_y(actor.rotation, trail_length))
      offscreen_buffer.line x1, y1, x2, y2, color:color, thickness:scaling_factor
    end

# - (trail_i * 5)
# - (trail_i * 5)
# - (trail_i * 5)
# - (trail_i * 5)

    offscreen_buffer.draw x, y, actor.layer


  end

end
