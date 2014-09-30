module Presenter
  class Base < SimpleDelegator
    # Public: Runs the given block once for each item in the array/relation,
    # wrapping each item with an instance of the specified presenter.
    #
    # presenter_name - The name of the presenter to use. Defaults to the default
    #                  model-specific presenter. (default: nil)
    # block          - The block that is run for each item in the array
    #
    # Yields the presenter-ified value of the iteration
    def each(presenter_name = nil, &block)
      presenter = Support.present!(model, presenter_name)

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
