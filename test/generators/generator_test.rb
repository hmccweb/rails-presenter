require 'test_helper'
require "generators/presenters/presenters_generator"

class PresentersGeneratorTest < GeneratorTestHelper
  tests Presenters::PresentersGenerator

  test "application presenter generation from template" do
    run_generator %w(PowerPoint)
    assert_file "app/presenters/power_point_presenter.rb"
  end
end
