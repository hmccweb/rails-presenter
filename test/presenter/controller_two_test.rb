require 'test_helper'

class BirthdaysControllerTest < ActionController::TestCase
  test "get index" do
    get :index

    assert_response :success
    assert_instance_of BirthdayPresenter, assigns(:birthdays)
  end
end
