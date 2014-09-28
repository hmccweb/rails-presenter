module Presenters
  class PresentersGenerator < Rails::Generators::NamedBase
    namespace "presenter"
    source_root File.expand_path("../templates", __FILE__)

    def create_presenter
      template "presenter.rb", "app/presenters/#{file_name}_presenter.rb"
    end
  end
end
