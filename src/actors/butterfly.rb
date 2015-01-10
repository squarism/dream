define_actor :butterfly do

  has_behaviors do
    positioned
    layered
    butterfly_shaped
    color_rotating hue_speed: 0.10, hue: 200
    rotating rotation_speed: 8
    trailing trails_to_render: 125
  end

end
