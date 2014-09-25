require 'test_helper'

class GiftsControllerTest < ActionController::TestCase
  test "get index" do
    get :index

    assert_response :success
    assert_instance_of WrappingPaperPresenter, assigns(:gifts)
  end
end
