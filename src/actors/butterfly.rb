define_actor :butterfly do

  has_behaviors do
    positioned
    layered
    butterfly_shaped
    color_rotating
    rotating
    trailing trails_to_render: 25
  end

end
