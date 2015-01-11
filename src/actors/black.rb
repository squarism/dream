# protip: gamebox has a curtain actor built-in
# but it only fades for a max of 4 seconds for some reason
# I want a longer fade to black.

define_actor :black do

  has_behaviors do
    graphical
    positioned
    layered
  end

end