define_actor :sun do
  has_attributes view: :graphical_actor_view

  has_behaviors do
    animated frame_update_time: 600, once: false
    graphical scale: 3
    positioned
  end

  behavior do
    setup do
      actor.has_attributes width: 150, height: 350
    end
  end
end