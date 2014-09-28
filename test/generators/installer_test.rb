require 'test_helper'
require "generators/presenters/install_generator"

class InstallerGeneratorTest < GeneratorTestHelper
  tests Presenters::InstallGenerator

  test "application presenter installation" do
    run_generator
    assert_file "app/presenters/application_presenter.rb"
  end
end
