define_actor :desk do
  has_attributes action: :idle, view: :graphical_actor_view

  has_behaviors do
    animated frame_update_time: 200
    graphical scale: 8
    fading time:5000
    layered layer:3
  end

  behavior do
    setup do
      actor.has_attributes width: 150, height: 350
    end
  end
end