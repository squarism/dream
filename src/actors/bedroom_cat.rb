define_actor :bedroom_cat do

  has_behaviors do
    animated frame_update_time: 400, once: false
    graphical scale: 5
    positioned
    layered
  end

end