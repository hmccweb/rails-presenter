module Presenters
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def install_presenter
      copy_file "application_presenter.rb", "app/presenters/application_presenter.rb"
    end
  end
end
