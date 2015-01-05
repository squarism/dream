define_actor :desk_night do
  has_attributes action: :idle, view: :graphical_actor_view

  has_behaviors do
    animated frame_update_time: 200
    graphical scale: 8
    fading
    layered
  end

end