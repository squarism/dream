define_actor :butterfly do

  has_behaviors do
    positioned
    layered
    butterfly_shaped
    color_rotating hue_speed: 0.15, hue: 120
    rotating rotation_speed: 31
    trailing trails_to_render: 30
  end

end
