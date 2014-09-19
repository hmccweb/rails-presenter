module Presenters
  class Base < SimpleDelegator
    # Public: Finds the specified presenter class
    #
    # model          - An instance of a class (usually a model or array of
    #                  models)
    # model_override - The class or class name of the presenter to use. Unless
    #                  falsy, this takes higher precidence than the model
    #                  argument.
    #
    # Examples
    #
    #   ApplicationPresenter.find_presenter(Foo.find(1), nil)
    #   # => FooPresenter
    #
    #   ApplicationPresenter.find_presenter(Foo.find(1), "bar")
    #   # => BarPresenter
    #
    #   ApplicationPresenter.find_presenter(ThisPresenterDoesntExist.find(1), nil)
    #   # => ApplicationPresenter
    #
    #   ApplicationPresenter.find_presenter(ArrayOfResults.where([1, 2, 3]), nil)
    #   # => ApplicationPresenter
    #
    # Returns the appropriate presenter class.
    def self.find_presenter(model, model_override = nil)
      presenter_name = model_override || model.class.name

      presenter = "#{presenter_name.to_s.capitalize}Presenter".constantize
    rescue NameError
      ApplicationPresenter
    end

    # Public: Runs the given block once for each item in the array/relation,
    # wrapping each item with an instance of the specified presenter.
    #
    # presenter_name - The name of the presenter to use. Defaults to the default
    #                  model-specific presenter. (default: nil)
    # block          - The block that is run for each item in the array
    #
    # Yields the presenter-ified value of the iteration
    def each presenter_name = nil, &block
      presenter = self.find_presenter(model, presenter_name)

      model.each do |m|
        block.call(presenter.new(m))
      end
    end

    # Public: Returns the object that the function calls are being delegated to.
    def model
      __getobj__
    end

    # Private: Alias of #model
    def relation
      __getobj__
    end
  end
end
