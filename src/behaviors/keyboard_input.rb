define_behavior :keyboard_input do
  requires :input_manager
  setup do
    i = input_manager
    i.while_pressed KbF, actor, :fade_out
  end
end
