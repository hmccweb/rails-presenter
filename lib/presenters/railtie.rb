module Presenters
  class Railtie < Rails::Railtie
    initializer "presenter.setup_action_controller" do |app|
      self.class_eval do
        include Controller
      end
    end
  end
end
