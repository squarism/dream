define_actor :walk_lamp do

  has_behaviors do
    animated frame_update_time: 800, once: false
    graphical scale: 3
    positioned
    layered
  end

end