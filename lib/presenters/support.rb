module Presenters
  module Support
    def self.get_presenter_from_string(str)
      str = str.camelize

      str << 'Presenter' unless str.match(/Presenter$/)

      str.constantize
    end

    def self.parse_override(override)
      case override
      when Class
        override
      when String
        get_presenter_from_string(override)
      end
    end
  end
end
