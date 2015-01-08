def prisim_vertices
  size = 75
  length = 200

  {
    face_vertices: [
      [  0, length ],
      [ size, length ],
      [ size, length + size ]
    ],
    back_vertices: [
      [ length, 0 ],
      [ length + size, 0 ],
      [ length + size, size],
    ]
  }
end


define_behavior :prism_shaped do
  requires :director

  setup do
    actor.has_attribute :face_vertices, prisim_vertices[:face_vertices]
    actor.has_attribute :back_vertices, prisim_vertices[:back_vertices]
  end
end