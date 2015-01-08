define_actor_view :dream_prism_view do
  draw do |screen, x_offset, y_offset, z|
    x = actor.x + x_offset
    y = actor.y + y_offset

    scaling_factor = 5
    texture_size = 500

    offscreen_buffer = TexPlay::create_blank_image(screen.screen, texture_size, texture_size)
    # very important to clear the buffer explicitly, otherwise you get random texture memory
    offscreen_buffer.clear color: :alpha

    white = Gosu::Color.new(0xffffffff)
    gray  = Gosu::Color.new(0xdfcccccc)

    # front face
    actor.face_vertices.each_with_index do |v, i|
      next_v = actor.face_vertices.rotate(i+1)[0]
      x1 = v[0]
      y1 = v[1]
      x2 = next_v[0]
      y2 = next_v[1]

      if i < 2
        offscreen_buffer.line( x1, y1, x2, y2, color:white, thickness:scaling_factor)
      else
        offscreen_buffer.line( x1, y1, x2, y2, color:gray, thickness:scaling_factor)
      end
    end

    # back face
    actor.back_vertices.each_with_index do |v, i|
      next_v = actor.back_vertices.rotate(i+1)[0]
      x1 = v[0]
      y1 = v[1]
      x2 = next_v[0]
      y2 = next_v[1]

      if i < 2
        offscreen_buffer.line( x1, y1, x2, y2, color:white, thickness:scaling_factor)
      else
        offscreen_buffer.line( x1, y1, x2, y2, color:gray, thickness:scaling_factor)
      end
    end

    # prism connector lines (the length of the prism shape)
    (0..1).to_a.each do |i|
      offscreen_buffer.line(
        actor.face_vertices[i][0],
        actor.face_vertices[i][1],
        actor.back_vertices[i][0],
        actor.back_vertices[i][1],
        color:white, thickness:scaling_factor
      )
    end

    offscreen_buffer.line(
      actor.face_vertices[2][0],
      actor.face_vertices[2][1],
      actor.back_vertices[2][0],
      actor.back_vertices[2][1],
      color:gray, thickness:scaling_factor
    )

    offscreen_buffer.draw x, y, actor.layer

  end
end
