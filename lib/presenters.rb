module Presenters
  module Present
    # Public: Finds the appropriate presenter
    #
    # model          - An instance of a class (usually a model or array of
    #                  models)
    # model_override - The name of the presenter to use instead (default: nil)
    #
    # Examples
    #
    #   present(Foo.find(1))
    #
    #   present(Foo.where([1, 2, 3]))
    #
    #   present(Foo.find(1), Bar)
    #   # => #<BarPresenter>
    #
    # Returns an instance of the presenter.
    def present(model, model_override = nil)
      presenter = ApplicationPresenter.find_presenter(model, model_override)

      presenter.new(model)
    end
  end

  class Railtie < Rails::Railtie
    initializer "presenter.setup_action_controller" do |app|
      self.class_eval do
        include Present
      end
    end
  end
end
