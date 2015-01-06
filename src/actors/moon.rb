define_actor :moon do
  has_attributes view: :graphical_actor_view

  has_behaviors do
    animated frame_update_time: 200, once: false
    graphical scale: 4
    positioned
    layered
  end

end