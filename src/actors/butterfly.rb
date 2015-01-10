define_actor :butterfly do

  has_behaviors do
    positioned
    layered
    butterfly_shaped
    color_rotating hue_speed: 0.10
    rotating rotation_speed: 8
    trailing trails_to_render: 100
  end

end
