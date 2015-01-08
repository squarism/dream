define_actor :dream_prism do
  has_attributes  #view:  :dream_prism_view

  has_behaviors do
    positioned
    layered
    prism_shaped
  end

end
