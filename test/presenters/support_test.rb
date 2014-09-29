require 'test_helper'

class PresentersSupportTest < ActiveSupport::TestCase
  test "string_to_presenter automatically appends 'Presenter'" do
    assert_equal ApplicationPresenter,
      Presenters::Support.string_to_presenter('application')

    assert_equal WrappingPaperPresenter,
      Presenters::Support.string_to_presenter('wrapping_paper')
  end

  test "string_to_presenter doesn't always re-append 'Presenter'" do
    assert_equal ApplicationPresenter,
      Presenters::Support.string_to_presenter('application_presenter')
  end

  test "string_to_presenter works with namespaces" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.string_to_presenter('admin/gift')
  end

  test "string_to_presenter works with if string is constantized" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.string_to_presenter('Admin::Gift')

    assert_equal Admin::GiftPresenter,
      Presenters::Support.string_to_presenter('Admin::GiftPresenter')
  end

  test "string_to_presenter throws errors if presenter is not found" do
    assert_raises NameError do
      Presenters::Support.string_to_presenter('this_does_not_exist')
    end
  end

  test "override_to_class_name returns the constant it was passed in" do
    assert_equal 'Admin::GiftPresenter',
      Presenters::Support.override_to_class_name(Admin::GiftPresenter)
  end

  test "override_to_class_name returns the constantized string" do
    assert_equal 'Admin::Gift',
      Presenters::Support.override_to_class_name('admin/gift')
  end

  # test "find_presenter" do
  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.find_presenter(Birthday.new)

  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.find_presenter(Gift.new, BirthdayPresenter)

  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.find_presenter(Gift.new, 'birthday')
  # end

  # test "choose_presenter" do
  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.choose_presenter(BirthdayPresenter)

  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.choose_presenter(Admin::GiftPresenter, BirthdayPresenter)

  #   assert_equal BirthdayPresenter,
  #     Presenters::Support.choose_presenter(Admin::GiftPresenter, 'birthday')
  # end

  test "instance_to_class_name model" do
    gift = Gift.new
    class_name = Presenters::Support.instance_to_class_name(gift)

    assert_equal "Gift", class_name
  end

  test "instance_to_class_name relation" do
    gift = Gift.all
    class_name = Presenters::Support.instance_to_class_name(gift)

    assert_equal "Gift", class_name
  end

  test "instance_to_class_name array" do
    gift = [Gift.new]
    class_name = Presenters::Support.instance_to_class_name(gift)

    assert_equal "Gift", class_name
  end
end
