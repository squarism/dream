define_stage :intro do
  # render_with :my_renderer

  curtain_up do |*args|
    opts = args.first || {}

    @message = create_actor :fading_text, text: "INTRO IN MY PANTS", x: 50, y:50, width: 25, height:35
    # @message = create_actor :label, x: 50, y: 50, font_size: 32, text: "Hello world!"
    @message.controller.map_controls '+f' => :fade_out
    @message.controller.map_controls '+g' => :fade_in
    # binding.pry
    # @message.fade_out
  end

  # helpers do
  #   include MyHelpers
  #   def help
  #     ...
  #   end
  # end
end
