define_actor :bedroom_covers do

  has_behaviors do
    animated frame_update_time: 540, once: false
    graphical scale: 5
    positioned
    layered
  end

end