module Presenters
  class Railtie < Rails::Railtie
    initializer "presenter.setup_action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Controller
      end
    end
  end
end
