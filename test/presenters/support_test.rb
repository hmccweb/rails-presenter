require 'test_helper'

class PresentersSupportTest < ActiveSupport::TestCase
  test "get_presenter_from_string automatically appends 'Presenter'" do
    assert_equal ApplicationPresenter,
      Presenters::Support.get_presenter_from_string('application')

    assert_equal WrappingPaperPresenter,
      Presenters::Support.get_presenter_from_string('wrapping_paper')
  end

  test "get_presenter_from_string doesn't always re-append 'Presenter'" do
    assert_equal ApplicationPresenter,
      Presenters::Support.get_presenter_from_string('application_presenter')
  end

  test "get_presenter_from_string works with namespaces" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.get_presenter_from_string('admin/gift')
  end

  test "get_presenter_from_string works with if string is constantized" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.get_presenter_from_string('Admin::Gift')

    assert_equal Admin::GiftPresenter,
      Presenters::Support.get_presenter_from_string('Admin::GiftPresenter')
  end

  test "get_presenter_from_string throws errors if presenter is not found" do
    assert_raises NameError do
      Presenters::Support.get_presenter_from_string('this_does_not_exist')
    end
  end

  test "parse_override returns the constant it was passed in" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.parse_override(Admin::GiftPresenter)
  end

  test "parse_override returns the constantized string" do
    assert_equal Admin::GiftPresenter,
      Presenters::Support.parse_override('admin/gift')
  end

  test "find_presenter" do
    assert_equal BirthdayPresenter,
      Presenters::Support.find_presenter(Birthday.new)

    assert_equal BirthdayPresenter,
      Presenters::Support.find_presenter(Gift.new, BirthdayPresenter)

    assert_equal BirthdayPresenter,
      Presenters::Support.find_presenter(Gift.new, 'birthday')
  end


  test "choose_presenter" do
    assert_equal BirthdayPresenter,
      Presenters::Support.choose_presenter(BirthdayPresenter)

    assert_equal BirthdayPresenter,
      Presenters::Support.choose_presenter(Admin::GiftPresenter, BirthdayPresenter)

    assert_equal BirthdayPresenter,
      Presenters::Support.choose_presenter(Admin::GiftPresenter, 'birthday')
  end
end
