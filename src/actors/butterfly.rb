define_actor :butterfly do

  has_behaviors do
    positioned
    layered
    butterfly_shaped
    color_rotating hue_speed: 0.5
    rotating rotation_speed: 0.5
    trailing trails_to_render: 5
  end

end
