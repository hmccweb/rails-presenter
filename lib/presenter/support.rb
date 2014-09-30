module Presenter
  module Support
    # Private: Parses a string to get the presenter
    #
    # Raises NameError if constant doesn't exist.
    #
    # Returns a Class
    def self.string_to_presenter(str)
      str = str.camelize

      str << 'Presenter' unless str.match(/Presenter$/)

      str.constantize
    end

    def self.instance_to_class_name(model_or_relation)
      name = model_or_relation.class.name

      if name == 'Array' && model_or_relation.first
        model_or_relation.first.class.name
      elsif name == 'ActiveRecord::Relation'
        model_or_relation.model.name
      else
        name
      end
    end

    def self.override_to_class_name(override)
      if override.instance_of? Class
        override.name
      elsif override.instance_of? String
        override.camelize
      end
    end

    def self.presenterize(class_name)
      string_to_presenter(class_name)
    rescue NameError
      ApplicationPresenter
    end

    def self.present!(instance, override)
      class_name =
        if override
          override_to_class_name(override)
        else
          instance_to_class_name(instance)
        end

      presenterize(class_name)
    end

    def self.present(instance, override)
      presenter = present!(instance, override)

      presenter.new(instance)
    end
  end
end
