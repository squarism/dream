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

    scaling_factor = 2
    texture_size = 256

    offscreen_buffer = TexPlay::create_blank_image(screen.screen, texture_size, texture_size)
    # very important to clear the buffer explicitly, otherwise you get random texture memory
    offscreen_buffer.clear color: :alpha

    # ARGH ... can't fade the buffer with a clear screen wipe
    # offscreen_buffer.clear color: Gosu::Color.new(10, 125, 125, 125)

    # Colorize our actor, this color acts as base brightness.
    # It doesn't matter where you put the ff in RGB because it rotates.
    # Relative RGB values will affect saturation.  Alpha works too.
    color_wheel = Gosu::Color.new(0xffff0000)
    color_wheel.hue = actor.hue

    scale = 255.0/actor.trails.size

    actor.trails.each.with_index do |s, i|
        x = s[:x]
        y = s[:y]
        sstart = [x - actor.width/2, y + actor.height/2]
        send   = [x + actor.width/2, y - actor.height/2]

        alpha = i * scale
        shadow_color = color_wheel.dup
        shadow_color.hue = s[:hue]
        shadow_color.alpha = alpha

        x1 = sstart[0] - (Gosu::offset_x(s[:rotation], actor.width/2))
        y1 = sstart[1] - (Gosu::offset_y(s[:rotation], actor.width/2))
        x2 = sstart[0] + (Gosu::offset_x(s[:rotation], actor.width/2))
        y2 = sstart[1] + (Gosu::offset_y(s[:rotation], actor.width/2))
        offscreen_buffer.line x1, y1, x2, y2, color:shadow_color, thickness:scaling_factor
    end

    # draw current
    lstart = [x - actor.width/2, y + actor.height/2]
    lend   = [x + actor.width/2, y - actor.height/2]

    # We draw lines from the origin to help in rotation.
    # You could think of it as a propeller with two pieces instead of one line
    # Otherwise, rotating 360º is hard.
    x1 = lstart[0] - (Gosu::offset_x(actor.rotation, actor.width/2))
    y1 = lstart[1] - (Gosu::offset_y(actor.rotation, actor.width/2))
    x2 = lstart[0] + (Gosu::offset_x(actor.rotation, actor.width/2))
    y2 = lstart[1] + (Gosu::offset_y(actor.rotation, actor.width/2))
    offscreen_buffer.line x1, y1, x2, y2, color:color_wheel, thickness:scaling_factor

    offscreen_buffer.draw x, y, actor.layer


  end

end
