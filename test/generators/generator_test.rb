require 'test_helper'
require "generators/presenter/presenters_generator"

class PresenterGeneratorTest < GeneratorTestHelper
  tests Presenter::PresenterGenerator

  test "application presenter generation from template" do
    run_generator %w(PowerPoint)
    assert_file "app/presenters/power_point_presenter.rb"
  end
end
