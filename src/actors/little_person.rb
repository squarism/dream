define_actor :little_person do

  has_behaviors do
    animated frame_update_time: 200, once: false
    graphical scale: 2
    positioned
    layered
  end

end