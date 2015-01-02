define_behavior :short_lived do
  requires :timer_manager
  setup do
    actor.has_attributes ttl: opts[:ttl] || 500

    timer_manager.add_timer timer_name, actor.ttl, false do
      actor.remove
    end
  end

  remove do
    timer_manager.remove_timer timer_name
  end

  helpers do
    def timer_name
      "ttl_#{self.object_id}"
    end
  end
end
