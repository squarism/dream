define_stage :intro do
  requires :behavior_factory

  curtain_up do |*args|
    # opts = args.first || {}

    gray = 90
    center = 280

    # pixel font doesn't do non-english characters that well
    i18n_font = "Tahoma"

    en = create_actor :fading_text, text: "DREAM", x: center, y:150
    ko = create_actor :fading_text, text: "꿈", x: center, y:190, font_size: 24, color: Color.new(255, gray, gray, gray), font_name: i18n_font
    es = create_actor :fading_text, text: "sueño", x: center, y:215, font_size: 16, color: Color.new(255, gray, gray, gray), font_name: i18n_font
    ar = create_actor :fading_text, text: "حلم", x: center, y:230, font_size: 24, color: Color.new(255, gray, gray, gray), font_name: i18n_font
    jp = create_actor :fading_text, text: "夢", x: center, y:255, font_size: 24, color: Color.new(255, gray, gray, gray), font_name: i18n_font


    fade_out_delay_t = 3500
    fade_out_t = 4500

    timer_manager.add_timer 'intro', fade_out_delay_t do
      timer_manager.remove_timer 'intro'
      en.emit :fade_out, fade_out_t
      ko.emit :fade_out, fade_out_t
      es.emit :fade_out, fade_out_t
      jp.emit :fade_out, fade_out_t
      ar.emit :fade_out, fade_out_t

      behavior_factory.add_behavior en, :sliding
      en.emit :slide, x:en.x, y:en.y + 10, time: fade_out_t
    end

    timer_manager.add_timer 'all_done', fade_out_delay_t + fade_out_t do
      fire :next_stage
    end

  end

end
