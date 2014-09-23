module Presenters
  module Support
    # Private: Parses a string to get the presenter
    #
    # Raises NameError if constant doesn't exist.
    #
    # Returns a Class
    def self.get_presenter_from_string(str)
      str = str.camelize

      str << 'Presenter' unless str.match(/Presenter$/)

      str.constantize
    end

    # Private: Turns an override argument into a presenter.
    #
    # Raises NameError if presenter does not exist.
    #
    # Returns a Class
    def self.parse_override(override)
      if override.instance_of? Class
        override
      elsif override.instance_of? String
        get_presenter_from_string(override)
      end
    end

    # Private: Finds the model name (given a model or an array of models)
    #
    # Returns a String or nil on error
    def self.get_model_name(model_or_relation)
      name = model_or_relation.class.name

      if name == 'Array' && model_or_relation.first
        model_or_relation.first.class.name
      elsif name.demodulize == 'ActiveRecord_Relation'
        model_or_relation.model.class.name
      else
        name
      end
    end

    # Private: Finds the specified presenter class
    #
    # model          - An instance of a class (usually a model or array of
    #                  models)
    # model_override - The class or class name of the presenter to use. Unless
    #                  falsy, this takes higher precidence than the model
    #                  argument.
    #
    # Examples
    #
    #   Support.find_presenter(Foo.find(1), nil)
    #   # => FooPresenter
    #
    #   Support.find_presenter(Foo.find(1), "bar")
    #   # => BarPresenter
    #
    #   Support.find_presenter(ThisPresenterDoesntExist.find(1), nil)
    #   # => ApplicationPresenter
    #
    #   Support.find_presenter(ArrayOfResults.where([1, 2, 3]), nil)
    #   # => ApplicationPresenter
    #
    # Returns the appropriate presenter class.
    def self.find_presenter(model, override = nil)
      if override
        parse_override(override)
      else
        model_name = get_model_name(model)
        get_presenter_from_string(model_name)
      end
    rescue NameError
      ApplicationPresenter
    end

    def self.choose_presenter(original_presenter, override = nil)
      if override
        parse_override(override)
      else
        original_presenter
      end
    end
  end
end
