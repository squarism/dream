define_stage :demo do
  # render_with :my_renderer

  curtain_up do |*args|
    opts = args.first || {}

    @player = create_actor :player, x: 10, y:30, width: 25, height:35
    # @message = create_actor :label, x: 50, y: 50, font_size: 32, text: "Hello world!"
    @player.controller.map_controls '+f' => :fade_out
  end

  # helpers do
  #   include MyHelpers
  #   def help
  #     ...
  #   end
  # end
end
